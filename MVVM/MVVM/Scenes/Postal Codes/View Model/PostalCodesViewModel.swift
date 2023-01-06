//
//  PostalCodesViewViewModel.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import WTestCommon
import WTestDomain
import Combine
import SwiftUI

protocol PostalCodesViewModelProtocol { }

final class PostalCodesViewModel: PostalCodesViewModelProtocol {
    // MARK: - Enums
    
    enum Action {
        case viewDidLoad
        case reloadDataSource
        case fetchPostalCodes
        case search(String?)
    }
    
    enum Strings { }
    
    enum ViewData: Hashable {
        case dataSourceModel(PostalCodeFieldsViewModel)
    }
    
    // MARK: - ViewInput
    
    var viewState: ViewInputObservable<ViewData>
    
    // MARK: - Properties
    
    private let proxyUseCase: ProxyPostalCodeUseCaseProtocol
    private let coordinator: PostalCodesCoordinatorProtocol
    private var postalCodes: [PostalCode] = []
    
    // MARK: - Publishers
    
    private let searchRequestTrigger: PassthroughSubject<String?, Never> = .init()
    private let isSearching: ActivityTracker = .init(false)
    
    private let disposeBag: CancellableBag = .init()
    private let endpointsBag: CancellableBag = .init()
    private let tempDisposeBag: CancellableBag = .init()
    
    // MARK: - Init
    
    init(viewState: ViewInputObservable<ViewData>,
         proxyUseCase: ProxyPostalCodeUseCaseProtocol,
         coordinator: PostalCodesCoordinatorProtocol) {
        self.viewState = viewState
        self.proxyUseCase = proxyUseCase
        self.coordinator = coordinator
        rxSetup()
    }
    
    // MARK: - Perform Action
    
    func performAction(_ action: Action) {
        tempDisposeBag.cancel()
        
        switch action {
        case .viewDidLoad:
            performAction(.reloadDataSource)
            performAction(.fetchPostalCodes)
        case .reloadDataSource:
            reloadDataSource()
        case .fetchPostalCodes:
            fetchPostalCodes()
        case .search(let searchTerm):
            searchRequestTrigger.send(searchTerm)
        }
    }
    
    
    // MARK: - Helpers
    
    private func rxSetup() {
        isSearching
            .sink { [weak self] value in
                self?.viewState.value.send(.isLoading(value))
            }
            .store(in: disposeBag)
        
        searchRequestTrigger
            .compactMap { $0 }
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] searchTerm in
                searchRequestBy(searchTerm)
            }
            .store(in: disposeBag)
    }
    
    private func present(_ action: Action,
                         content: Any? = nil) {
        switch action {
        case .viewDidLoad: break
        case .reloadDataSource: break
        case .fetchPostalCodes: break
        case .search: break
        }
    }
    
    private func fetchPostalCodes() {
        endpointsBag.cancel()
        
        proxyUseCase.fetchPostalCodes()
            .trackActivity(isSearching)
            .replaceError(with: [])
            .sink { [weak self] postalCodes in
                self?.postalCodes = postalCodes
                self?.performAction(.reloadDataSource)
            }
            .store(in: endpointsBag)
    }
    
    private func searchRequestBy(_ searchTerm: String) {
        tempDisposeBag.cancel()
        
        proxyUseCase.searchPostalCodes(withText: searchTerm)
            .trackActivity(isSearching)
            .replaceError(with: [])
            .sink { [weak self] postalCodes in
                self?.postalCodes = postalCodes
                self?.performAction(.reloadDataSource)
            }
            .store(in: tempDisposeBag)
    }
    
    private func reloadDataSource() {
        let postalCodeFields = postalCodes.map { PostalCodeFieldViewModel(local: $0.local,
                                                                          number: $0.number) }
        let postalCodesVM = PostalCodeFieldsViewModel(postalCodeFields: postalCodeFields)
        viewState.value.send(.load(.dataSourceModel(postalCodesVM)))
    }
}
