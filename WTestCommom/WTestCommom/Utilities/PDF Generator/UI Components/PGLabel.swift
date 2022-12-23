//
//  PGLabel.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

class PGLabel: PGHtmlElement {
    private var text: String = ""
    
    var container: PGContainer = PGContainer()
    
    var html: String {
        return "\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
    
    func renderHtml() -> String {
        return container.renderHtml(self)
    }
}
