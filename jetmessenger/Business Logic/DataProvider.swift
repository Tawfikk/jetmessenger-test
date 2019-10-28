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

protocol DataProvider: class {
    func obtainMembers(offset: Int) -> Observable<[MembersModelList]>
}

final class DataProviderImplementation: DataProvider {
        
    private var networkService: Network
    private var cacheService: CacheService
    
    // MARK: - Constructor 🏗
    init(network: Network, cache: CacheService) {
        self.cacheService = cache
        self.networkService = network
    }
    
    //
    func obtainMembers(offset: Int) -> Observable<[MembersModelList]> {
        
    }
}
