//
//  PostalCodeUseCase.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import WTestDomain
import Combine

enum PostalCodeUseCaseError: LocalizedError {
    case appAlreadyLaunched
    
    public var errorDescription: String? {
        switch self {
        case .appAlreadyLaunched:
            return "appAlreadyLaunched"
        }
    }
}

protocol PostalCodeUseCaseType: AnyObject {
    func savePostalCodes(_ postalCodes: [PostalCode]) -> ObservableType<Void>
    func downloadPostalCodes() -> ObservableType<[PostalCode]>
    func fetchPostalCodes() -> ObservableType<[PostalCode]>
    func searchPostalCodes(withText text: String) -> ObservableType<[PostalCode]>
}

final class PostalCodeUseCase: PostalCodeUseCaseType {
    private let repository: PostalCodesRepositoryType
    
    @UserDefault(key: "isAppAlreadyLaunched", defaultValue: false)
    var isAppAlreadyLaunched: Bool
    
    init(repository: PostalCodesRepositoryType) {
        self.repository = repository
    }
    
    func downloadPostalCodes() -> ObservableType<[PostalCode]> {
        guard isAppAlreadyLaunched == false else {
            return Empty<[PostalCode], Never>().asObservable()
        }
        
        return repository.downloadPostalCodes()
    }
    
    func savePostalCodes(_ postalCodes: [PostalCode]) -> ObservableType<Void> {
        isAppAlreadyLaunched = true
        return repository.savePostalCodes(postalCodes)
    }
    
    func fetchPostalCodes() -> ObservableType<[PostalCode]> {
        return repository.fetchPostalCodes(withPredicate: nil)
    }
    
    func searchPostalCodes(withText text: String) -> ObservableType<[PostalCode]> {
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
