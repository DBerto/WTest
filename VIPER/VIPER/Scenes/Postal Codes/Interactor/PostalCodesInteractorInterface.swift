//
//  PostalCodesInteractorInterface.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain
import WTestCommon

class PostalCodesInteractor: PostalCodesInteractorInterface {
    
    weak var presenter: PostalCodesPresenterInterface!
    let repository: PostalCodesRepositoryType!
    private let disposeBag: CancellableBag = .init()
    
    init(repository: PostalCodesRepositoryType) {
        self.repository = repository
    }
    
    func fetchPostalCodes() {
        repository.fetchPostalCodes(withPredicate: nil)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter.fetchPostalCodesFailed(error)
                }
            }, receiveValue: { [weak self] postalCodes in
                self?.presenter.fetchPostalCodesSucceed(postalCodes)
            })
            .store(in: disposeBag)
    }
    
    func searchPostalCodes(withText text: String) {
        guard !text.isEmpty else {
            fetchPostalCodes()
            return
        }
        
        let predicate = createPredicate(withText: text)
        repository.fetchPostalCodes(withPredicate: predicate)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter.fetchPostalCodesFailed(error)
                }
            }, receiveValue: { [weak self] postalCodes in
                self?.presenter.fetchPostalCodesSucceed(postalCodes)
            })
            .store(in: disposeBag)
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
