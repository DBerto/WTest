//
//  UICollectionView+Register.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerHeader<T: UICollectionReusableView>(_ cellType: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.className)
    }
    
    func registerFooter<T: UICollectionReusableView>(_ cellType: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.className)
    }
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.className)
    }
}
