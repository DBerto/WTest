//
//  PGTemplate.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

struct PGTemplate: PGHtmlElement {
    
    let contentAnchor = "###PGCONTENT###"
    let styleAnchor = "###PGSTYLE###"

    private var htmlUrl: URL!
    private var htmlSource: Result<String, Error> {
        do {
            let html = try String(contentsOf: htmlUrl)
            return .success(html)
        } catch let error {
            return .failure(error)
        }
    }

    private var elements: [PGHtmlElement]
    private var globalStyles: [String] = []

    var html: String {
        if case let .success(html) = self.htmlSource {
            return html
        }
        
        return ""
    }
    
    init(htmlTemplateUrl: URL, elements: [PGHtmlElement]) {
        self.htmlUrl = htmlTemplateUrl
        self.elements = elements
    }

    mutating func addGlobalStyle(cssStyle: String) {
        globalStyles.append(cssStyle)
    }

    func renderHtml() -> String {
        var htmlElements = ""
        var styles = ""
        
        for element in elements {
            htmlElements += element.renderHtml()
        }
        
        for style in globalStyles {
            styles += "\(style)"
        }

        return self.html.replacingOccurrences(of: contentAnchor, with: htmlElements).replacingOccurrences(of: styleAnchor, with: styles)
    }
}
