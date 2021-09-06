//
//  LoadingScreenInteractor.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain
import WTestCommon

enum LoadingScreenInteractorError: LocalizedError {
    case downloadError
    
    public var errorDescription: String? {
        switch self {
        case .downloadError:
            return R.string.localizable.postalCodesDownloadError()
        }
    }
}

class LoadingScreenInteractor: LoadingScreenInteractorInterface {
    
    weak var presenter: LoadingScreenPresenterInterface!
    let repository: PostalCodesRepositoryType!
    
    init(repository: PostalCodesRepositoryType) {
        self.repository = repository
    }
    
    private var isAppAlreadyLaunched: Bool = {
        return UserDefaults.standard.bool(forKey: "isAppAlreadyLaunched")
    }()
    
    func fetchPostalCodes() {
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
    
    func savePostalCodes(_ postalCodes: [PostalCode]) {
        repository.savePostalCodes(postalCodes) { [weak self] (result) in
            switch result {
            case .success:
                UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunched")
                self?.presenter.postalCodeSaveSucceed()
            case .failure(let error):
                self?.presenter.postalCodeSaveFailed(error)
            }
        }
    }
}
