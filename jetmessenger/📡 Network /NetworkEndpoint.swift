//
//  NetworkEndpoint.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Moya

enum NetworkEndpoint {
    case members(offset: Int, count: Int)
}

extension NetworkEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://open.rocket.chat/api/v1")!
    }
    
    var path: String {
        switch self {
        case .members: return "/channels.members"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .members(let offset, let count):
            var parameters: [String: Any] = [:]
            parameters["count"] = count
            parameters["offset"] = offset
            parameters["roomName"] = UserConstants.roomName
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var headersValue: [String: String] = [:]
        headersValue["X-User-Id"] = UserConstants.userID
        headersValue["X-Auth-Token"] = UserConstants.userToken
        
        return headersValue
    }
}
