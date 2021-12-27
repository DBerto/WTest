//
//  MainScreenViewController.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol MainScreenViewControllerType: BaseViewController {
    var viewDidLoadTrigger: Trigger { get }
}

class MainScreenViewController: BaseViewController, MainScreenViewControllerType {
    
    // MARK: - Properties
    private(set) var viewDidLoadTrigger: Trigger = .init()
    
    var viewModel: MainScreenViewModel!
    
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
            make.trailing.equalToSuperview().inset(40)
        }
        
        postalCodesButton.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        _ = viewModel.transform(input: MainScreenViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger.asDriver()),
                                disposeBag: disposeBag)
    }
}
