//
//  FillableProtocol.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation

protocol FillableProtocol {
    associatedtype DataType
    
    func fill(_ data: DataType)
}
