//
//  PGHtmlElement.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

protocol PGClassStyle {
    var cssClass: String { get set }
}

protocol PGHtmlStyle {
    var cssStyle: String { get set }
}

protocol PGHtmlElement {
    var html: String { get }
    func renderHtml() -> String
}

protocol PGHtmlContainer {
    var elements: [PGHtmlElement] { get }
}
