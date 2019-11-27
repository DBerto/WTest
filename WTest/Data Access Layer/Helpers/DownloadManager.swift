//
//  DownloadManager.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

final class DownloadManager: IDownloadManager{
    func loadFileAsync(url: URL, destination: URL, completion: @escaping (Bool) -> Void) {
        if FileManager().fileExists(atPath: destination.path) {
            print("The file already exists at \(destination.path), deleting and replacing with latest")
            
            if FileManager().isDeletableFile(atPath: destination.path){
                do{
                    try FileManager().removeItem(at: destination)
                    print("previous file deleted")
                    self.saveFile(url: url, destination: destination) { (complete) in
                        if complete{
                            completion(true)
                            print("The file will be saved at \(destination.path)")
                        }else{
                            completion(false)
                        }
                    }
                }catch{
                    print("current file could not be deleted")
                }
            }
            // download the data from your url
        }else{
            self.saveFile(url: url, destination: destination) { (complete) in
                if complete{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
    }
    func saveFile(url: URL, destination: URL, completion: @escaping (Bool) -> Void){
        URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
            // after downloading your data you need to save it to your destination url
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let location = location, error == nil
                else { print("error with the url response"); completion(false); return}
            do {
                try FileManager.default.moveItem(at: location, to: destination)
                print("new file saved")
                completion(true)
            } catch {
                print("file could not be saved: \(error)")
                completion(false)
            }
        }).resume()
    }
}

protocol IDownloadManager {
    func loadFileAsync(url: URL, destination: URL, completion: @escaping (Bool) -> Void)
    func saveFile(url: URL, destination: URL, completion: @escaping (Bool) -> Void)
}
