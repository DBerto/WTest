//
//  PostalCodeService.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import CSVImporter

final class PostalCodeService: IPostalCodeService{
    
    // MARK: Properties
    private let downloadManager: IDownloadManager
    private let postalCodeDal: IPostalCodeDal
    
    init(downloadManager: IDownloadManager, postalCodeDal: IPostalCodeDal) {
        self.downloadManager = downloadManager
        self.postalCodeDal = postalCodeDal
    }
    
    // MARK: Functions
    
    // Download Service
    func downloadAndSavePostalCodes(from postalCodeUrl: URL, to destinationURL: URL, completion: @escaping (Bool) -> Void) {
        if arePostalCodesDownloaded(){
            completion(true)
            return
        }

        self.markPostalCodesDownloadOperation(asDownloaded: false)
        downloadManager.loadFileAsync(url: postalCodeUrl, destination: destinationURL, completion: {
            (complete) in
            if complete{
                self.markPostalCodesDownloadOperation(asDownloaded: true)
               completion(true)
            }else{
               completion(false)
            }
        })
    }
    private func markPostalCodesDownloadOperation(asDownloaded: Bool){
        UserDefaults.standard.set(asDownloaded.toString(), forKey: "isPostalCodeDownloaded")
    }
    private func arePostalCodesDownloaded()-> Bool{
        guard let result = UserDefaults.standard.string(forKey: "isPostalCodeDownloaded") else{
            return false
        }
        return result == true.toString()
    }
    
    // Parse CSV
    func parseCSVToPostalCodeList(originPath: String, completion: @escaping ([PostalCode]) -> Void) {
        let path = originPath
        let importer = CSVImporter<PostalCode>(path: path)
        
        importer.startImportingRecords { recordValues -> PostalCode in
            return PostalCode(numCodPostal: recordValues[14], extCodPostal: recordValues[15], desigPostal: recordValues[16])
        }.onFinish { importedRecords in
            // Ignora os repetidos
            var newImportedRecords = importedRecords.uniques
            // Ignore the first line bc is the file header
            _ = newImportedRecords.remove(at: 0)
            completion(newImportedRecords)
        }
        
    }

    // Realm Service
    func savePostalCodeListToRealm(postalCodeList: [PostalCode])-> Bool{
        markPostalCodesRealmOperation(asSaved: false)
        let result = postalCodeDal.insertMany(postalCodeList: postalCodeList)
        if(result){
            markPostalCodesRealmOperation(asSaved: true)
        }
        return result
    }
    private func markPostalCodesRealmOperation(asSaved: Bool){
          UserDefaults.standard.set(asSaved.toString(), forKey: "isPostalCodeSaved")
      }
    private func arePostalCodesSaved()-> Bool{
        guard let result = UserDefaults.standard.string(forKey: "isPostalCodeSaved") else{
            return false
        }
        return result == true.toString()
    }

}
