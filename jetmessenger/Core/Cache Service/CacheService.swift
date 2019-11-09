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
    func cache(_ objects: Object)
//    func cache(_ objects: Object) -> Single<Bool>
    func retrieveMembers(by offset: Int) -> Observable<[MembersModelList]>
}

final class CacheServiceImplementation: CacheService {
    
    
    // MARK: - Constructor 🏗
    init() {
    }
    
    func cache(_ objects: Object) {
        let realm = try! Realm()
        try? realm.write {            
            realm.add(objects, update: .all)
        }
    }
    
//    func cache(_ objects: Object) -> Single<Void> {
//        return Single.create { single in
//            let realm = try! Realm()
//            do {
//                try realm.write {
//                    realm.add(objects, update: .all)
//                    single(.success(()))
//                }
//            } catch let error {
//                single(.error(error))
//            }
//            return Disposables.create()
//        }
//    }
    
    func retrieveMembers(by offset: Int) -> Observable<[MembersModelList]> {
        let realm = try! Realm()
        guard let members = realm.object(ofType: MembersModel.self, forPrimaryKey: offset) else { return Observable.just([]) }
        return Observable.collection(from: members.members).map { $0.toArray() }
    }
    
//    func cache(_ objects: Object) -> Observable<Bool> { //
//        return Observable.create { observe in
//            let realm = try! Realm()
//
//            do {
//                try realm.write {
//                    realm.add(objects, update: .modified)
//                    observe.onNext(true)
//                }
//            } catch {
//                observe.onNext(false)
//            }
//
//            return Disposables.create()
//        }
//    }
}
