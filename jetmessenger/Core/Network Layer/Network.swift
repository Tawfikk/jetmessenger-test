//
//  Network.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Moya
import RxSwift

protocol Network: class {
    func getMembers(offset: Int, count: Int) -> Single<MembersModel>
}

final class NetworkImplementation: Network {

    private let provider = MoyaProvider<NetworkEndpoint>()
    
    // MARK: - Constructor 🏗
    init() {
    }
    
    //
    func getMembers(offset: Int, count: Int) -> Single<MembersModel> {
        return provider.rx
            .request(.members(offset: offset, count: count))
            .map(MembersModel.self)
    }
}
