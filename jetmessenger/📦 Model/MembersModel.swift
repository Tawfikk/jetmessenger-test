//
//  MembersModel.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation

struct MembersModel: Codable {
    let members: [MembersModelList]
}

struct MembersModelList: Codable {
    let id: String
    let name: String
    let status: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case status
    }
}
