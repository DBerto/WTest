//
//  LoadingScreenViewController.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol LoadingScreenViewControllerrType: class {
    var viewDidLoadTrigger: Variable<Void?> { get set }
    var viewWillAppearTrigger: Variable<Void?> { get set }
}

class LoadingScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    var viewModel: LoadingScreenViewModel!
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    var viewDidLoadTrigger: Variable<Void?> = .init(nil)
    var viewWillAppearTrigger: Variable<Void?> = .init(nil)

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
    
    func bindViewModel() {
        let output = viewModel.transform(input: LoadingScreenViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger,
                                                                             viewWillAppearTrigger: viewWillAppearTrigger))
        
        output.loadingViewModel.onUpdate = { [weak self] value in

        }
    }
}
