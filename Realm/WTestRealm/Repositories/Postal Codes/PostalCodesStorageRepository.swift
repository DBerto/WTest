//
//  PostalCodesStorageRepository.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import RealmSwift
import WTestDomain

public final class PostalCodesStorageRepository: BaseStorageRepository, PostalCodesStorageRepositoryInterface {
    
    public func createPostalCode(_ postalCode: PostalCode, completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = self.realm
        
        //        do {
        //            try realm.write {
        //                let profile = realm.object(ofType: ProfileModel.self,
        //                                           forPrimaryKey: userId) ?? ProfileModel(userId: userId)
        //                realm.add(profile, update: .all)
        //                completion(.success(()))
        //            }
        //        } catch {
        //            completion(.failure(error))
        //        }
    }
    
    // MARK: - Services
    
    public func fetchPostalCodes(completion: @escaping (Result<[PostalCode], Error>) -> Void) {
        //        do {
        //            let profile = try fetchProfile(for: userId)
        //            let favoriteServices = Array(profile.favoriteServices.map { $0.asService() })
        //            completion(.success(favoriteServices))
        //        } catch {
        //            completion(.failure(error))
        //        }
    }
}
