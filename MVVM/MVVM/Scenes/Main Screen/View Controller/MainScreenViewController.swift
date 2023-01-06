//
//  MainScreenViewController.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol MainScreenViewControllerProtocol: BaseViewController {
    var viewModel: MainScreenViewModel! { get set }
}

class MainScreenViewController: BaseViewController,
                                MainScreenViewControllerProtocol {
    
    // MARK: - Properties
    
    var viewModel: MainScreenViewModel!
    private(set) var input: ViewInputObservable<MainScreenViewModel.ViewData> = .init()
    
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
        button.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.performAction(.showPostalCodes)
            }
            .store(in: disposeBag)
        return button
    }()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        bindViewModel()
        viewModel.performAction(.viewDidLoad)
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
        viewModel.viewState
            .sink { viewData in
                switch viewData {
                case .load: break
                case .isLoading: break
                }
            }
            .store(in: disposeBag)
    }
}
