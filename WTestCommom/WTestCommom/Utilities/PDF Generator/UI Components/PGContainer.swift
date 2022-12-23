//
//  PGContainer.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

class PGContainer: PGHtmlElement, PGHtmlContainer, PGHtmlStyle, PGClassStyle {

    var elements: [PGHtmlElement] = []
    var html: String {
        return ""
    }

    var cssStyle: String = ""
    var cssClass: String = ""

    func renderHtml() -> String {
        return "<div class=\"\(cssClass)\" style=\"\(cssStyle)\">\(elements.map { $0.renderHtml() }.joined())</div>"
    }

    func renderHtml(_ htmlElement: PGHtmlElement) -> String {
        return "<div class=\"\(cssClass)\" style=\"\(cssStyle)\">\(htmlElement.html)</div>"
    }
}
