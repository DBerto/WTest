//
//  PGPageBreak.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

class PGPageBreak: PGHtmlElement {
    var html: String {
        return ""
    }
    
    var container: PGContainer = PGContainer()

    init() {
        container.cssStyle = "page-break-before: always;"
    }

    func renderHtml() -> String {
        return container.renderHtml(self)
    }
}
