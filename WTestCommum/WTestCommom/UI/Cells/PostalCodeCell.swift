//
//  PostalCodeCell.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

public class PostalCodeCell: BindableBaseCell {
    
    // MARK: - Properties
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var localLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(localLabel)
        setupConstraints()
    }
    
    // MARK: - Layout
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.bottomMargin.topMargin.rightMargin.leadingMargin.equalToSuperview()
        }
        
        numberLabel.setContentHuggingPriority(.required, for: .horizontal)
        numberLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: - Bindings
    
    public func bindViewModel<T: FieldViewModel>(_ viewModel: T){
        let viewModel = viewModel as! PostalCodeFieldViewModel
        numberLabel.text = viewModel.number
        localLabel.text = viewModel.local
        layoutIfNeeded()
    }
    
}
