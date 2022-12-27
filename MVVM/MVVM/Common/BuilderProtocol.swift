//
//  BuilderProtocol.swift
//  MVVM
//
//  Created by Berto, David Manuel  on 27/12/2022.
//

import Foundation
import WTestCommon

protocol BuilderProtocol: AnyObject {
    func setup() -> BaseViewController
}
