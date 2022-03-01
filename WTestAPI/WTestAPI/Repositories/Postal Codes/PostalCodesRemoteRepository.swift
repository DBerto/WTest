//
//  PostalCodesRemoteRepository.swift
//  WTestAPI
//
//  Created by David Berto on 21/09/2021.
//

import Foundation
import WTestCommon
import Combine

public protocol PostalCodesRemoteRepositoryType {
    func downloadPostalCodes() -> Future<[PostalCodeResponse], Error>
}

public final class PostalCodesRemoteRepository: BaseRemoteRepository, PostalCodesRemoteRepositoryType {
    public func downloadPostalCodes() -> Future<[PostalCodeResponse], Error> {
        Future<[PostalCodeResponse], Error> { promise in
            let postalCodeUrl = URL(string: Configuration.postalCodeURL)
            var postalCodes: [PostalCodeResponse] = []
            
            do {
                let contents = try String(contentsOf: postalCodeUrl!)
                var postalCodeStringList = contents.components(separatedBy: .newlines)
                postalCodeStringList.remove(at: 0)
                postalCodeStringList.remove(at: postalCodeStringList.count - 1)
                
                for postalCodeContent in postalCodeStringList {
                    let elements = postalCodeContent.components(separatedBy: ",")
                    let number =  (elements[elements.endIndex - 3]) + "-" + (elements[elements.endIndex - 2])
                    let local = (elements[elements.endIndex - 1])
                    let postalCode = PostalCodeResponse(local: local, number: number)
                    postalCodes.append(postalCode)
                }
                promise(.success(postalCodes))
            } catch(let error) {
                promise(.failure(error))
            }
        }
    }
}
