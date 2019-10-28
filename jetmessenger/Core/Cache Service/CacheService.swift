//
//  CacheService.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import RealmSwift
import Realm
import RxSwift
import RxRealm

protocol CacheService: class {
    func cache(_ objects: [Object], for offset: Int) -> Observable<Bool>
    func retrieveMembers(by offset: Int) -> Observable<[MembersModelList]>
}

final class CacheServiceImplementation: CacheService {
    
    
    // MARK: - Constructor 🏗
    init() {
    }
        
    func retrieveMembers(by offset: Int) -> Observable<[MembersModelList]> {
        let realm = try! Realm()
        var members: [MembersModelList] = []
        guard let arrayMembers = realm.object(ofType: MembersModel.self, forPrimaryKey: offset)?.members else {
            return Observable.just(members)
        }
        
        members = Array(arrayMembers)
        return Observable.just(members)
    }
    
    func cache(_ objects: [Object],  for offset: Int) -> Observable<Bool> {
        return Observable.create { observe in
            let realm = try! Realm()
                    
            do {
                try realm.write {
                    realm.add(objects, update: .modified)
                    observe.onNext(true)
                }
            } catch {
                observe.onNext(false)
            }
            
            return Disposables.create()
        }
    }
}
