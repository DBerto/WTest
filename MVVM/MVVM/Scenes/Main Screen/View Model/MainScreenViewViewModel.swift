//
//  MainScreenViewViewModel.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import WTestCommon
import Combine

protocol MainScreenViewModelType: ViewModelType { }

final class MainScreenViewModel: MainScreenViewModelType {
    // MARK: - Enums
    
    enum Action {
        case viewDidLoad
        case showPostalCodes
        case showError(Error)
    }
    
    enum Strings {
        
    }
    
    // MARK: - Input/Output
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
        let postalCodesButtonTrigger: Driver<Void>
    }
    
    struct Output { }
    
    // MARK: - Properties
    
    private let coordinator: MainScreenCoordinatorType
    
    // MARK: - Publishers
    
    private let errorTracker: ErrorTracker = .init()
    
    // MARK: - Init
    
    init(coordinator: MainScreenCoordinatorType) {
        self.coordinator = coordinator
    }
    
    // MARK: - Transform
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        
        input.viewDidLoadTrigger
            .sink { [unowned self] in
                performAction(.viewDidLoad)
            }
            .store(in: disposeBag)
        
        input.postalCodesButtonTrigger
            .sink { [unowned self] in
                performAction(.showPostalCodes)
            }
            .store(in: disposeBag)
        
        errorTracker
            .asDriver()
            .sink { [weak self] error in
                self?.performAction(.showError(error))
            }
            .store(in: disposeBag)
        
        return Output()
    }
    
    
    // MARK: - Helpers
    
    private func performAction(_ action: Action) {
        switch action {
        case .viewDidLoad: break
        case .showPostalCodes:
            coordinator.perform(.showPostalCodes)
        case .showError(let error):
            coordinator.perform(.error(error))
        }
    }
}
