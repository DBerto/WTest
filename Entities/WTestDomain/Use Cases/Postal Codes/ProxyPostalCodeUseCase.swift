//
//  ProxyPostalCodesRemoteRepository.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 05/01/2023.
//

import Foundation
import Combine
import WTestCommon

public protocol ProxyPostalCodeUseCaseProtocol: PostalCodeUseCaseProtocol {
    func downloadPostalCodes(cachePolicy: CachePolicy) -> ObservableType<[PostalCode]>
}

public final class ProxyPostalCodeUseCase: ProxyPostalCodeUseCaseProtocol {
    public let useCase: PostalCodeUseCaseProtocol
    
    public init(useCase: PostalCodeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // MARK: - Proxy Functions
    
    public func downloadPostalCodes(cachePolicy: CachePolicy) -> ObservableType<[PostalCode]> {
        let key: String = #function
        let cache: CacheManager<String, [PostalCode]> = .init()
        let cachedValue: [PostalCode]? = cache.value(forKey: key)
        
        switch cachePolicy {
        case .ignoringCache:
            return useCase.downloadPostalCodes()
        case .cacheElseLoad:
            guard let cachedValue = cachedValue else {
                return useCase.downloadPostalCodes()
            }
            return Just<[PostalCode]>(cachedValue).asObservable()
        case .cacheAndLoad:
            return Publishers.Merge(
                Just<[PostalCode]>(cachedValue ?? []).asObservable(),
                useCase.downloadPostalCodes().compactMap {
                    cache.insert($0, forKey: key)
                    return $0
                }
            ).asObservable()
        case .cacheDontLoad:
            return useCase.downloadPostalCodes()
        }
    }
    
    // MARK: - ByPass Proxy Functions
    
    public func savePostalCodes(_ postalCodes: [PostalCode]) -> ObservableType<Void> {
        useCase.savePostalCodes(postalCodes)
    }
    
    public func downloadPostalCodes() -> ObservableType<[PostalCode]> {
        useCase.downloadPostalCodes()
    }
    
    public func fetchPostalCodes() -> ObservableType<[PostalCode]> {
        useCase.fetchPostalCodes()
    }
    
    public func searchPostalCodes(withText text: String) -> ObservableType<[PostalCode]> {
        useCase.searchPostalCodes(withText: text)
    }
}
