//
//  LoadingScreenViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class LoadingScreenViewController: BaseViewController, LoadingScreenViewInterface {
    
    // MARK: - Properties
    
    weak var eventHandler: LoadingScreenEventHandler!
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        eventHandler.viewIsLoaded()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.addSubview(loadingView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        loadingView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - LoadingScreenEventHandler
    
    func updateView(with viewModel: LoadingViewModel) {
        loadingView.viewModel = viewModel
    }
    
}
