//
//  CacheService.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import RealmSwift
import RxSwift

protocol CacheService: class {
    func cache(_ objects: [Object], for offset: Int) -> Observable<Bool>
    func retrieveMembers() -> Observable<[MembersModelList]>
}

final class CacheServiceImplementation: CacheService {
    
    
    // MARK: - Constructor 🏗
    init() {
    }
        
    func retrieveMembers() -> Observable<[MembersModelList]> {
        let realm = try! Realm()
        let membersArray = Array(realm.objects(MembersModelList.self))
        return Observable.just(membersArray)
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
