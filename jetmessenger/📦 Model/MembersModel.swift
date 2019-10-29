//
//  MembersModel.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class MembersModel: Object, Decodable {
    @objc dynamic var count = 0
    @objc dynamic var total = 0
    @objc dynamic var offset = 0
    @objc dynamic var success = true
    let members = List<MembersModelList>()
    
    override class func primaryKey() -> String? {
        return "offset"
    }
    
    private enum CodingKeys: String, CodingKey {
        case count
        case total
        case offset
        case success
        case members
    }

    required convenience  init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try container.decode(Int.self, forKey: .count)
        self.total = try container.decode(Int.self, forKey: .total)
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.success = try container.decode(Bool.self, forKey: .success)
        
        let members = try container.decodeIfPresent([MembersModelList].self, forKey: .members) ?? []
        self.members.append(objectsIn: members)
    }
     
}

class MembersModelList: Object, Decodable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    @objc dynamic var userName: String? = ""
    @objc dynamic var statusText: String? = ""
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case status
        case userName = "username"
        case statusText
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
