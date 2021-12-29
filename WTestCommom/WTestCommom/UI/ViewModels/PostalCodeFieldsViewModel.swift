//
//  PostalCodesViewModel.swift
//  WTestCommon
//
//  Created by David Berto on 29/12/2021.
//

import Foundation

open class PostalCodeFieldsViewModel: TableViewModelBase {
    public init(postalCodeFields: [PostalCodeFieldViewModel]) {
        super.init()
        sections = [ViewModelSection(fields: postalCodeFields)]
    }
}
