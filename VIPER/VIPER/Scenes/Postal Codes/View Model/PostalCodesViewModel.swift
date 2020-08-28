//
//  PostalCodesViewModel.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

class PostalCodesViewModel: TableViewModelBase {
    init(postalCodes: [PostalCodeViewModel]) {
        super.init()
        sections = [ViewModelSection(fields: postalCodes)]
    }
}
