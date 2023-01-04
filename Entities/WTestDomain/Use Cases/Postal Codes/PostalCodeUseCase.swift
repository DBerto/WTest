//
//  PostalCodeUseCase.swift
//  WTestDomain
//
//  Created by Berto, David Manuel  on 04/01/2023.
//  Copyright © 2023 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestCommon
import Combine

public enum PostalCodeUseCaseError: LocalizedError {
    case appAlreadyLaunched
    
    public var errorDescription: String? {
        switch self {
        case .appAlreadyLaunched:
            return "appAlreadyLaunched"
        }
    }
}

public protocol PostalCodeUseCaseProtocol: AnyObject {
    func savePostalCodes(_ postalCodes: [PostalCode]) -> ObservableType<Void>
    func downloadPostalCodes() -> ObservableType<[PostalCode]>
    func fetchPostalCodes() -> ObservableType<[PostalCode]>
    func searchPostalCodes(withText text: String) -> ObservableType<[PostalCode]>
}

public final class PostalCodeUseCase: PostalCodeUseCaseProtocol {
    private let repository: PostalCodesRepositoryProtocol
    
    @UserDefault(key: "isAppAlreadyLaunched", defaultValue: false)
    public var isAppAlreadyLaunched: Bool
    
    public init(repository: PostalCodesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func downloadPostalCodes() -> ObservableType<[PostalCode]> {
        guard isAppAlreadyLaunched == false else {
            return Empty<[PostalCode], Never>().asObservable()
        }
        
        return Future(asyncFunc: { [unowned self] in
            try await repository.downloadPostalCodes()
        }).asObservable()
    }
    
    public func savePostalCodes(_ postalCodes: [PostalCode]) -> ObservableType<Void> {
        isAppAlreadyLaunched = true
        return repository.savePostalCodes(postalCodes)
    }
    
    public func fetchPostalCodes() -> ObservableType<[PostalCode]> {
        return repository.fetchPostalCodes(withPredicate: nil)
    }
    
    public func searchPostalCodes(withText text: String) -> ObservableType<[PostalCode]> {
        guard !text.isEmpty else {
            return fetchPostalCodes()
        }
        
        let predicate = createPredicate(withText: text)
        return repository.fetchPostalCodes(withPredicate: predicate)
    }
    
    private func createPredicate(withText text: String) -> NSPredicate {
        let splitedText = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).split(separator: " ")
        let format = "local CONTAINS[cd] %@ OR number CONTAINS[cd] %@"
        var subPredicates: [NSPredicate] = []
        
        if splitedText.count <= 1 {
            let textToSearch = splitedText.joined()
            let subPredicate = NSPredicate(format: format, textToSearch, textToSearch)
            subPredicates.append(subPredicate)
        } else {
            splitedText.forEach { (text) in
                let textToSearch = text.description
                let subPredicate = NSPredicate(format: format, textToSearch, textToSearch)
                subPredicates.append(subPredicate)
            }
        }
        
        return NSCompoundPredicate(type: .and, subpredicates: subPredicates)
    }
}
