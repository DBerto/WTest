//
//  PostalCodeViewModel.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

public class PostalCodeFieldViewModel: FieldViewModel {
    let local: String?
    let number: String?
    
    public init(local: String?,
                number: String?) {
        self.local = local
        self.number = number
    }
}
