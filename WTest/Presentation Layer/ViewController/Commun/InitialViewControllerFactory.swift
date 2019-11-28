//
//  InitialViewControllerFactory.swift
//  WTest
//
//  Created by David Berto on 28/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

class InitialViewControllerFactory{
    
    let postalCodeService: IPostalCodeService!
    
    init(postalCodeService: IPostalCodeService) {
        self.postalCodeService = postalCodeService
    }
    
    func make()-> UIViewController{
        
        var storyBoardName = ""
        var identifier = ""
        
        if postalCodeService.arePostalCodesDownloaded() && postalCodeService.arePostalCodesSaved(){
            storyBoardName  = "Menu"
            identifier = "MenuViewController"
        }else{
            storyBoardName  = "Main"
            identifier = "DownlPostalCodeViewController"
        }        
        
        let storyboard = UIStoryboard.init(name: storyBoardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
