//
//  MainScreenViewViewModel.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import WTestCommon
import Combine
import SwiftUI

protocol MainScreenViewModelProtocol { }

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Enums
    
    enum Action {
        case viewDidLoad
        case showPostalCodes
        case showError(Error)
    }
    
    enum Strings { }
    
    enum ViewData: Hashable { }
    
    // MARK: - ViewInput

    var viewState: ViewInputObservable<ViewData>

    // MARK: - Properties

    private let coordinator: MainScreenCoordinatorProtocol
    
    // MARK: - Publishers
    
    private let errorTracker: ErrorTracker = .init()
    private let disposeBag: CancellableBag = .init()
    
    // MARK: - Init
    
    init(viewState: ViewInputObservable<ViewData>,
         coordinator: MainScreenCoordinatorProtocol) {
        self.coordinator = coordinator
        self.viewState = viewState
        rxSetup()
    }
    
    // MARK: - Perform Action
    
    func performAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            present(action)
        case .showPostalCodes:
            present(action)
        case .showError(let error):
            present(action, content: error)
        }
    }
    
    // MARK: - Helpers
    
    private func rxSetup() {
        errorTracker
            .asDriver()
            .sink { [weak self] error in
                self?.performAction(.showError(error))
            }
            .store(in: disposeBag)
    }
    
    private func present(_ action: Action,
                         content: Any? = nil) {
        let error: Error? = content as? Error
        
        switch action {
        case .viewDidLoad: break
        case .showPostalCodes:
            coordinator.perform(.showPostalCodes)
        case .showError:
            guard let error = error else { return }
            coordinator.perform(.error(error))
        }
    }
}
