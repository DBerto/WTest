//
//  LoadingScreenInteractor.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

class LoadingScreenInteractor: LoadingScreenInteractorInterface {
    
    weak var presenter: LoadingScreenPresenterInterface!
    
    private var isAppAlreadyLaunched: Bool = {
        return UserDefaults.standard.bool(forKey: "isAppAlreadyLaunched")
    }()
    
    init() {
        
    }
    
    func fetchPostalCodes() {
        guard let postalCodeUrl = URL(string: Configuration.postalCodeURL), !isAppAlreadyLaunched else {
            self.presenter?.postalCodeFetchFailed()
            return
        }
        do {
            let contents = try String(contentsOf: postalCodeUrl)
            var postalCodeStringList = contents.components(separatedBy: .newlines)
            postalCodeStringList.remove(at: 0)
            postalCodeStringList.remove(at: postalCodeStringList.count - 1)
            for postalCodeContent in postalCodeStringList {
                let elements = postalCodeContent.components(separatedBy: ",")
                let postalCode =  (elements[elements.endIndex - 3]) + "-" + (elements[elements.endIndex - 2])
                let local = (elements[elements.endIndex - 1])
                //                let postalCodeModel = PostalCodeModel(name: local, number: number)
                //                _PostalCodeList.append(postalCodeModel)
            }
            //            savePostalCodeDb(postalCodeArray: _PostalCodeList)
            UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunched")
        } catch {
            self.presenter?.postalCodeFetchFailed()
        }
    }
    
    
}
