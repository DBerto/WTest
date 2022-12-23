//
//  PGPdfTemplate.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import WebKit

protocol PGPdfTemplate: NSObject, WKNavigationDelegate {
    associatedtype InputData

    var webView: WKWebView { get }
    var completion: PGCompletion? { get set }
    var data: InputData { get set }
    var navigationDelegate: WKNavigationDelegate? { get set }

    func generatePdf(completion: @escaping PGCompletion)
    func renderHtml() -> String
}

extension PGPdfTemplate {
    func generatePdf(completion: @escaping PGCompletion) {
        self.completion = completion
        let html = renderHtml()
        if let resourcePath = Bundle.main.resourcePath {
            let url = URL.init(fileURLWithPath: resourcePath)
            webView.loadHTMLString(html, baseURL: url)
        }
    }
}
