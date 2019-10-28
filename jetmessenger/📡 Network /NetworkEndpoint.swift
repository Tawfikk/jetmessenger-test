//
//  NetworkEndpoint.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Moya

enum NetworkEndpoint {
    case members
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
        case .members:
            var parameters: [String: String] = [:]
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
