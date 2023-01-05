//
//  LoadingScreenViewModel.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import WTestDomain
import Combine

protocol LoadingScreenViewModelProtocol: ViewModelProtocol { }

final class LoadingScreenViewModel: LoadingScreenViewModelProtocol {
    // MARK: - Enums
    
    enum Action {
        case viewDidLoad
        case reloadDataSource
        case downloadPostalCodes
        case savePostalCodes([PostalCode])
        case showMainScreen
        case showError(Error)
    }
    
    enum Strings {
        static let downloadingLabel = R.string.localizable.downloadingLabel()
        static let savingLabel      = R.string.localizable.savingLabel()
    }
    
    // MARK: - Input/Output
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }
    
    struct Output {
        let dataSourceModel: PassthroughSubject<LoadingViewModel, Never>
    }
    
    // MARK: - Properties
    
    private let proxyPostalCodeUseCase: ProxyPostalCodeUseCaseProtocol
    private let coordinator: LoadingScreenCoordinatorProtocol
    
    private lazy var loadingViewModel: LoadingViewModel = {
        LoadingViewModel(title: R.string.localizable.appTitle(),
                         image: #imageLiteral(resourceName: "post-box"),
                         downloadingLabel: Strings.downloadingLabel,
                         isDownloading: true)
    }()
    
    // MARK: - Publishers
    
    private let dataSourceModel: PassthroughSubject<LoadingViewModel, Never> = .init()
    private let errorTracker: ErrorTracker = .init()
    private var disposeBag: CancellableBag!
    
    // MARK: - Init
    
    init(proxyPostalCodeUseCase: ProxyPostalCodeUseCaseProtocol,
         coordinator: LoadingScreenCoordinatorProtocol) {
        self.proxyPostalCodeUseCase = proxyPostalCodeUseCase
        self.coordinator = coordinator
    }
    
    // MARK: - Transform
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        self.disposeBag = disposeBag
        
        input.viewDidLoadTrigger
            .sink { [unowned self] _ in
                performAction(.viewDidLoad)
                performAction(.downloadPostalCodes)
            }
            .store(in: disposeBag)
        
        errorTracker
            .asDriver()
            .sink { [weak self] error in
                self?.performAction(.showError(error))
            }
            .store(in: disposeBag)
        
        return Output(dataSourceModel: dataSourceModel)
    }
    
    
    // MARK: - Helpers
    
    private func performAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            performAction(.reloadDataSource)
        case .reloadDataSource:
            reloadDataSource()
        case .downloadPostalCodes:
            downloadPostalCodes()
        case .savePostalCodes(let postalCodes):
            savePostalCodes(postalCodes)
        case .showMainScreen:
            coordinator.perform(.showMainScreen)
        case .showError(let error):
            coordinator.perform(.error(error))
        }
    }
    
    private func reloadDataSource() {
        dataSourceModel.send(loadingViewModel)
    }
    
    private func downloadPostalCodes() {
        proxyPostalCodeUseCase.downloadPostalCodes(cachePolicy: .cacheElseLoad)
            .trackError(errorTracker)
            .asDriver()
            .sink { [weak self] postalCodes in
                self?.loadingViewModel.downloadingLabel = Strings.savingLabel
                self?.performAction(.reloadDataSource)
                self?.performAction(.savePostalCodes(postalCodes))
            }
            .store(in: disposeBag)
    }
    
    private func savePostalCodes(_ postalCodes: [PostalCode]) {
        proxyPostalCodeUseCase.savePostalCodes(postalCodes)
            .trackError(errorTracker)
            .asDriver()
            .sink { [weak self] postalCodes in
                self?.performAction(.showMainScreen)
            }
            .store(in: disposeBag)
    }
}
