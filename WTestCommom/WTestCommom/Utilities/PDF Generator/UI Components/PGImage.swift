//
//  PGImage.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

class PGImage: PGHtmlElement, PGClassStyle, PGHtmlStyle {
    private var imageData: Data!
    private var base64Image: String = ""

    var container: PGContainer = PGContainer()

    var cssStyle: String = ""
    var cssClass: String = ""

    var html: String {
        return "<img src=\"\(base64Image)\" class=\"\(cssClass)\" style=\"\(cssStyle)\">"
    }

    init(imagePath: URL) {
        self.imageData = UIImage(contentsOfFile: imagePath.path)?.pngData()
        setup()
    }
    
    init(image: UIImage) {
        self.imageData = image.pngData()
        setup()
    }
    
    private func setup() {
        base64Image = String(format: "data:image/png;base64,%@", imageData.base64EncodedString())
    }

    func renderHtml() -> String {
        return container.renderHtml(self)
    }
}
