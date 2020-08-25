//
//  LoadingView.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    
    lazy var title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imgvw = UIImageView()
        return imgvw
    }()
    
    lazy var downloadingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addSubview(verticalStackView)
        backgroundColor = .white
        verticalStackView.addArrangedSubview(title)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(downloadingLabel)
        verticalStackView.addArrangedSubview(activityIndicator)
        setupConstraints()
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(80)
        }
    }
    
    // MARK: - Biding
    
    var viewModel: LoadingViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            bind(viewModel)
        }
    }
    
    private func bind(_ loadingViewModel: LoadingViewModel) {
        title.text = loadingViewModel.title
        imageView.image = loadingViewModel.image
        downloadingLabel.text = loadingViewModel.downloadingLabel
        loadingViewModel.isDownloading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
