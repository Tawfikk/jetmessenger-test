//
//  MembersModel.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RealmSwift

class MembersModel: Object, Codable {
    @objc dynamic var count = 0
    @objc dynamic var total = 0
    @objc dynamic var offset = 0
    @objc dynamic var success = true
    let members = List<MembersModelList>()
    
    override class func primaryKey() -> String? {
        return "offset"
    }
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
