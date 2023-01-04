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
import WTestAPI

enum LoadingScreenInteractorError: LocalizedError {
    case downloadError
    case appAlreadyLaunched
    
    public var errorDescription: String? {
        switch self {
        case .downloadError:
            return R.string.localizable.postalCodesDownloadError()
        case .appAlreadyLaunched:
            return "appAlreadyLaunched"
        }
    }
}

final class LoadingScreenInteractor: LoadingScreenInteractorInterface {
    
    weak var presenter: LoadingScreenPresenterInterface!
    
    private let repository: PostalCodesRepositoryProtocol!
    private let disposeBag: CancellableBag = .init()
    
    init(repository: PostalCodesRepositoryProtocol) {
        self.repository = repository
    }
    
    @UserDefault(key: "isAppAlreadyLaunched", defaultValue: false)
    var isAppAlreadyLaunched: Bool
    
    func fetchPostalCodes() {
        guard !isAppAlreadyLaunched else {
            presenter.postalCodeFetchFailed(LoadingScreenInteractorError.appAlreadyLaunched)
            return
        }
        
        repository.downloadPostalCodes()
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?.presenter.postalCodeFetchFailed(LoadingScreenInteractorError.downloadError)
                }
            }, receiveValue: { [weak self] postalCodes in
                self?.presenter.postalCodeFetchSucceed(postalCodes)
            })
            .store(in: disposeBag)
    }
    
    func savePostalCodes(_ postalCodes: [PostalCode]) {
        repository.savePostalCodes(postalCodes)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.presenter.postalCodeFetchFailed(error)
                }
            }, receiveValue: { [weak self] _ in
                self?.isAppAlreadyLaunched = true
                self?.presenter.postalCodeSaveSucceed()
            })
            .store(in: disposeBag)
    }
}
