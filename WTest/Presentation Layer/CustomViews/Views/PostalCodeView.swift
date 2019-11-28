//
//  PostalCodeView.swift
//  WTest
//
//  Created by David Berto on 28/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

class PostalCodeView: UIView{

    // MARK: UIProperties
    @IBOutlet weak var postalCodeNum: UILabel!
    @IBOutlet weak var postalCodeExt: UILabel!
    @IBOutlet weak var postalCodeDesc: UILabel!
    @IBOutlet var postalCodeView: UIView!
    
    // MARK: Overrides
       override init(frame: CGRect) { // for using CustomView in code
           super.init(frame: frame)
           initToCode()
           commonInit(view: postalCodeView)
       }
       
       required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
           super.init(coder: aDecoder)
           guard let view = initToIB() else { return }
           self.addSubview(view)
           commonInit(view: view)
       }
       
       // MARK: Functions
       fileprivate func initToCode() {
           Bundle.main.loadNibNamed("PostalCodeView", owner: self, options: nil)
           addSubview(postalCodeView)
       }
       
       fileprivate func initToIB() -> UIView? {
           let bundle = Bundle(for: type(of: self))
           let nib = UINib(nibName: "PostalCodeView", bundle: bundle)
           return nib.instantiate(withOwner: self, options: nil).first as? UIView
       }
       
       fileprivate func commonInit(view: UIView) {
           view.translatesAutoresizingMaskIntoConstraints = false
           addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": view]))
           addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": view]))
       }
}
