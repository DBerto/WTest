//
//  PGPageRenderer.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

class PGPageRenderer: UIPrintPageRenderer {
    let sizeA4PageWidth: CGFloat = 595.2
    let sizeA4PageHeight: CGFloat = 841.8
    
    override init() {
        super.init()
        setup(useHeaderAndFooter: false)
    }
    
    init(useHeaderAndFooter: Bool = false) {
        super.init()
        setup(useHeaderAndFooter: useHeaderAndFooter)
    }

    private func setup(useHeaderAndFooter: Bool) {
        // Specify the frame of the A4 page.
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: sizeA4PageWidth, height: sizeA4PageHeight)

        // Set the page frame.
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        self.setValue(NSValue(cgRect: pageFrame.insetBy(dx: 0.0, dy: 0.0)), forKey: "printableRect")

        let headerAndFooterSize = CGFloat(useHeaderAndFooter ? 50.0 : 0.0)
        self.headerHeight = headerAndFooterSize
        self.footerHeight = headerAndFooterSize
    }
}
