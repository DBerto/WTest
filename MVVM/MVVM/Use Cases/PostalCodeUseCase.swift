//
//  PostalCodeUseCase.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation

protocol PostalCodeUseCaseType: class {
    func fetchPostalCodes(completion: @escaping (Result<[PostalCode], [Error]>) -> Void)
    func fetchCustomerFromRemote(with customerId: String, customerSegment: Int32, completion: @escaping (Result<Customer?, Error>) -> Void)
}

class PostalCodeUseCase: PostalCodeUseCaseType {
    
    private let repository: PostalCodesStorageRepositoryType
    
    init(repository: PostalCodesStorageRepositoryType) {
        self.repository = repository
    }
    
    func fetchPostalCodes(completion: @escaping (Result<[PostalCode], [Error]>) -> Void) {
        guard let postalCodeUrl = URL(string: Configuration.postalCodeURL), !isAppAlreadyLaunched else { return }
        var errors: [Error] = []
        var postalCodes: [PostalCode] = []
        
        do {
            let contents = try String(contentsOf: postalCodeUrl)
            var postalCodeStringList = contents.components(separatedBy: .newlines)
            postalCodeStringList.remove(at: 0)
            postalCodeStringList.remove(at: postalCodeStringList.count - 1)
            
            for postalCodeContent in postalCodeStringList {
                let elements = postalCodeContent.components(separatedBy: ",")
                let number =  (elements[elements.endIndex - 3]) + "-" + (elements[elements.endIndex - 2])
                let local = (elements[elements.endIndex - 1])
                let postalCode = PostalCode(local: local, number: number)
                postalCodes.append(postalCode)
            }
        } catch {
            errors.append(LoadingScreenInteractorError.downloadError)
        }
        
        if errors.isEmpty {
            self.presenter.postalCodeFetchSucceed(postalCodes)
        } else {
            self.presenter.postalCodeFetchFailed(LoadingScreenInteractorError.downloadError)
        }
    }

}
