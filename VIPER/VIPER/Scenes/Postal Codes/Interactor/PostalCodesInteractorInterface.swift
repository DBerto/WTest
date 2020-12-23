//
//  PostalCodesInteractorInterface.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

class PostalCodesInteractor: PostalCodesInteractorInterface {
    
    weak var presenter: PostalCodesPresenterInterface!
    let databaseRepository: PostalCodesStorageRepositoryType!
    
    init(databaseRepository: PostalCodesStorageRepositoryType) {
        self.databaseRepository = databaseRepository
    }
    
    func fetchPostalCodes() {
        databaseRepository.fetchPostalCodes(withPredicate: nil) { [weak self] (result) in
            switch result {
            case .success(let postalCodes):
                self?.presenter.fetchPostalCodesSucceed(postalCodes)
            case .failure(let error):
                self?.presenter.fetchPostalCodesFailed(error)
            }
        }
    }
    
    func searchPotalCodes(withText text: String) {
        guard !text.isEmpty else {
            fetchPostalCodes()
            return
        }
        
        let predicate = createPredicate(withText: text)
        databaseRepository.fetchPostalCodes(withPredicate: predicate) { [weak self] (result) in
            switch result {
            case .success(let postalCodes):
                self?.presenter.fetchPostalCodesSucceed(postalCodes)
            case .failure(let error):
                self?.presenter.fetchPostalCodesFailed(error)
            }
        }
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
