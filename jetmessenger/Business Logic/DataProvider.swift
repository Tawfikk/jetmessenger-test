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

protocol DataProvider: class {
    func obtainMembers(offset: Int) -> Observable<[MembersModelList]>
}

final class DataProviderImplementation: DataProvider {
        
    // MARK: - Private Properties 🕶
    private let bag = DisposeBag()
    private var networkService: Network
    private var cacheService: CacheService
    
    private var membersModel = BehaviorRelay<[MembersModel]>(value: [])
    private var membersCache = BehaviorRelay<[MembersModelList]>(value: [])
    
    // MARK: - Constructor 🏗
    init(network: Network, cache: CacheService) {
        self.cacheService = cache
        self.networkService = network
    }
    
    //
    func obtainMembers(offset: Int) -> Observable<[MembersModelList]> {
        return Observable.combineLatest(cacheService.retrieveMembers(by: offset), networkService.getMembers(offset: offset).asObservable()) { cache, network in
            guard cache.count != 0 else { return network.members.toArray() }
            return cache
        }
    }
}
