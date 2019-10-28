//
//  MembersModel.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RealmSwift

struct MembersModel: Codable {
    let members: [MembersModelList]
}

class MembersModelList: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case status
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
