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
    func obtainMembers(offset: Int) -> BehaviorRelay<[MembersModelList]>
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
    func obtainMembers(offset: Int) -> BehaviorRelay<[MembersModelList]> {
        cacheService.retrieveMembers(by: offset).bind(to: membersCache).disposed(by: bag)
        networkService.getMembers(offset: offset).asObservable().bind(to: membersModel)
    }
}
