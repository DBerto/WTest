//
//  ApiCacheManager.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 05/01/2023.
//

import Foundation
import WTestCommon

// https://blog.devgenius.io/caching-with-nscache-in-ios-2e97be8d6b53

public enum ApiCachePolicy: String, CaseIterable {
    case ignoringCache
    case cacheElseLoad
    case cacheAndLoad
    case cacheDontLoad
}

public protocol ApiCacheManagerProtocol<Key, Value> {
    associatedtype Key
    associatedtype Value
    
    func insert(_ value: Value,
                forKey key: Key,
                timeToLiveInMinutes: Int)
    func insert(_ value: Value,
                forKey key: Key)
    func value(forKey key: Key) -> Value?
    func removeValue(forKey key: Key)
}

public final class ApiCacheManager<Key: Hashable, Value>: ApiCacheManagerProtocol {
    // MARK: - KeyWrapper
    
    public final class KeyWrapper: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        public override var hash: Int {
            key.hashValue
        }
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? KeyWrapper else { return false }
            return value.key == key
        }
    }
    
    // MARK: - CacheEntry
    
    public final class CacheEntry {
        let value: Value
        let expiryDate: Date?
        
        init(value: Value,
             expiryDate: Date? = nil) {
            self.value = value
            self.expiryDate = expiryDate
        }
    }
    
    // MARK: - Public Properties
    
    public let cache: NSCache<KeyWrapper, CacheEntry>
    
    // MARK: - Init
    
    public init(cache: NSCache<KeyWrapper, CacheEntry> = .init()) {
        self.cache = cache
    }
    
    // MARK: - Subscript

    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
    
    // MARK: - Functions
    
    public func insert(_ value: Value,
                forKey key: Key,
                timeToLiveInMinutes: Int = 5) {
        let timeInSeconds: Double = .init(timeToLiveInMinutes * 60)
        let expiryDate: Date = Date.now.addingTimeInterval(timeInSeconds)
        let entry: CacheEntry = .init(value: value,
                                      expiryDate: expiryDate)
        
        cache.setObject(entry,
                        forKey: KeyWrapper(key))
    }
    
    public func insert(_ value: Value,
                forKey key: Key) {
        let entry: CacheEntry = .init(value: value)
        cache.setObject(entry,
                        forKey: KeyWrapper(key))
    }
    
    public func value(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: KeyWrapper(key)) else { return nil }
        guard let expiryDate = entry.expiryDate else { return entry.value }
        
        
        guard Date().isBefore(date: expiryDate) else {
            // Discard values that have expired
            removeValue(forKey: key)
            return nil
        }
        
        return entry.value
    }
    
    public func removeValue(forKey key: Key) {
        cache.removeObject(forKey: KeyWrapper(key))
    }
}
