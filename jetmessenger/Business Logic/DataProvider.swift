//
//  DataProvider.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

protocol DataProvider: class {
    func obtainUser(by id: String) -> Observable<MembersModelList>
    func obtainMembers(offset: Int) -> Observable<[MembersModelList]>
}

final class DataProviderImplementation: DataProvider {
    
    // MARK: - Private Properties 🕶
    private let bag = DisposeBag()
    private var networkService: Network
    private var cacheService: CacheService
    
    
    // MARK: - Constructor 🏗
    init(network: Network, cache: CacheService) {
        self.cacheService = cache
        self.networkService = network
    }
    
    //
    func obtainUser(by id: String) -> Observable<MembersModelList> {
        let realm = try! Realm()
        guard let user = realm.object(ofType: MembersModelList.self, forPrimaryKey: id) else { return Observable.empty() }
        return .just(user)
    }
    
    //
    func obtainMembers(offset: Int) -> Observable<[MembersModelList]> {
        return cacheService.retrieveMembers(by: offset)
            .flatMap { [weak self] members -> Observable<[MembersModelList]> in
                guard let `self` = self else { return Observable.empty()}
                guard members.isEmpty == false else {
                    return self.networkService.getMembers(offset: offset).asObservable()
                        .do(onNext: { members in
                            _ = self.cacheService.cache(members)
                        }).map { $0.members.toArray() }.asObservable()
                }
                return .just(members)
        }.asObservable()
                
        //        return Observable.combineLatest(cacheService.retrieveMembers(by: offset), networkService.getMembers(offset: offset).asObservable()) { cacheModel, networkModel in
        //            guard cacheModel.count != 0 else {
        //                 return networkModel.members.toArray()
        //            }
        //            return cacheModel
        //        }
    }
}
