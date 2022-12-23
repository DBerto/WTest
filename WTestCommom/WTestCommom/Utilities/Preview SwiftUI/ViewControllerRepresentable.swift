//
//  ViewControllerRepresentable.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit
import SwiftUI

// https://swiftwithmajid.com/2021/03/10/mastering-swiftui-previews/
// https://medium.com/swlh/how-to-use-live-previews-in-uikit-204f028df3a9

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> UIViewController
    
    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}

struct ViewRepresentable: UIViewRepresentable {
    let viewBuilder: () -> UIView
    
    init(_ viewBuilder: @escaping () -> UIView) {
        self.viewBuilder = viewBuilder
    }
    
    func makeUIView(context: Context) -> some UIView {
        viewBuilder()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not needed
    }
}

struct SizeCategoryPreview<Content: View>: View {
    let content: Content

    var body: some View {
        ForEach(ContentSizeCategory.allCases, id: \.self) { size in
            content.environment(\.sizeCategory, size)
        }
    }
}
