//
//  LoadingViewModel.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

public class LoadingViewModel {
    var title: String
    var image: UIImage
    var downloadingLabel: String
    var isDownloading: Bool
    
    init(title: String, image: UIImage, downloadingLabel: String, isDownloading: Bool) {
        self.title = title
        self.image = image
        self.downloadingLabel = downloadingLabel
        self.isDownloading = isDownloading
    }
}
