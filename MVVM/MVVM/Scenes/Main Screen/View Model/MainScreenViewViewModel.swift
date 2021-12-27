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
    
    // MARK: - Properties
    
    private let coordinator: MainScreenCoordinatorType
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }
    
    struct Output { }
    
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
            .sink { [weak self] in
                self?.viewDidLoadTrigger()
            }
            .store(in: disposeBag)
        
        errorTracker
            .asDriver()
            .sink { [weak self] error in
                self?.coordinator.perform(.error(error))
            }
            .store(in: disposeBag)
        
        return Output()
    }
    
    
    // MARK: - Helpers
    
    private func viewDidLoadTrigger() { }
}
