//
//  ViewController.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import UIKit

class DownlPostalCodeViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    // MARK: Services
    var postalCodeService: IPostalCodeService!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()        
        // regist services
        postalCodeService = AppDelegate.container.resolve(IPostalCodeService.self)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let postalCodeUrl = URL(string: Config.postalCodeUrl)!
        let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destinationURL = documentsUrl.appendingPathComponent(postalCodeUrl.lastPathComponent)
        downloadPostalCodes(from: postalCodeUrl, to: destinationURL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: Functions
    func downloadPostalCodes(from postalCodeUrl: URL, to destinationURL: URL){
        print("Downloading Postal Codes...")
        self.postalCodeService.downloadAndSavePostalCodes(from: postalCodeUrl, to: destinationURL, completion: {
            (complete) in
            if complete{
                print("Downloaded Postal Codes with success")
                DispatchQueue.main.async {
                    self.loadingLabel.text = "A ler ficheiro de códigos postais!"
                }
                print("Parsing CSV Postal Codes...")
                self.postalCodeService.parseCSVToPostalCodeList(originPath: destinationURL.path, completion: {
                    (postalCodeList) in
                    print("Parsed CSV Postal Codes")
                    print("Saving Postal Codes to Realm...")
                    self.loadingLabel.text = "A armazenar ficheiro de códigos postais!"
                    DispatchQueue.global(qos: .utility).async {
                        self.postalCodeService = AppDelegate.container.resolve(IPostalCodeService.self)!
                        let result = self.postalCodeService.savePostalCodeListToRealm(postalCodeList: postalCodeList)
                        if result{
                            print("Saved Postal Codes to Realm")
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "goToMenu", sender: self)
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.showAlertBar(title: "Error", message: "Erro ao guardar os códigos postais.")
                                self.progressIndicator.stopAnimating()
                                print("Error on saving Postal Codes to Realm")           
                            }
                        }
                    }
                    
                })
            }else{
                DispatchQueue.main.async {
                    self.loadingLabel.text = "Erro ao descarregar os códigos postais."
                    self.showAlertBar(title: "Error", message: "Erro ao descarregar os códigos postais.")
                    self.progressIndicator.stopAnimating()
                    print("Error on downloading Postal Codes")
                }
            }
        })
        
    }
}

