//
//  LoadingScreenViewController.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol LoadingScreenViewControllerType: BaseViewController {
    var viewDidLoadTrigger: Trigger { get }
}

class LoadingScreenViewController: BaseViewController, LoadingScreenViewControllerType {
    
    // MARK: - Properties
    
    private(set) var viewDidLoadTrigger: Trigger = .init()
    
    var viewModel: LoadingScreenViewModel!
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.addSubview(loadingView)
        setupConstraints()
    }
    
    private func setupNavBar() {
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    private func setupConstraints() {
        loadingView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        let output = viewModel.transform(input: LoadingScreenViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger.asDriver()),
                                         disposeBag: disposeBag)
        
        output.dataSourceModel
            .asDriver()
            .sink { [weak self] (dataSourceModel) in
                self?.loadingView.viewModel = dataSourceModel
                self?.view.setNeedsDisplay()
            }
            .store(in: disposeBag)
    }
}
