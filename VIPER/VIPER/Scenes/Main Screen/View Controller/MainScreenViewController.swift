//
//  MainScreenViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import WTestCommon

class MainScreenViewController: BaseViewController, MainScreenViewInterface {
    
    // MARK: - Properties
    
    var eventHandler: MainScreenEventHandler!
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var postalCodesButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.postalCodes(), for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(postalCodesButtonAction), for: .touchDown)
        return button
    }()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(postalCodesButton)
        setupConstraints()
    }
    
    private func setupNavBar() {
        navigationItem.title = R.string.localizable.mainScreenTitle()
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        postalCodesButton.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Actions
    
    @objc private func postalCodesButtonAction() {
        eventHandler.postalCodesButtonPressed()
    }
}
