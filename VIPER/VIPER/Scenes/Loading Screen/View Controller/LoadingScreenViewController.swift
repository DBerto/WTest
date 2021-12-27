//
//  LoadingScreenViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import WTestCommon

class LoadingScreenViewController: BaseViewController, LoadingScreenViewInterface {
    
    // MARK: - Properties
    
    var eventHandler: LoadingScreenEventHandler!
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView() 
        return view
    }()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        eventHandler.viewIsLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventHandler.viewAppeared()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.addSubview(loadingView)
        setupConstraints()
    }
    
    private func setupNavBar() {
        navigationController?.setToolbarHidden(true,
                                               animated: false)
    }
    
    private func setupConstraints() {
        loadingView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset( 10)
            make.leading.equalToSuperview().offset(10)
        }
    }
        
    // MARK: - LoadingScreenEventHandler
    
    func updateView(with viewModel: LoadingViewModel) {
        loadingView.viewModel = viewModel
        view.setNeedsDisplay()
    }
}
