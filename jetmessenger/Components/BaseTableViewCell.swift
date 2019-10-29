//
//  BaseTableViewCell.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
     // MARK: - LifeCycle 🌏
       override func awakeFromNib() {
           super.awakeFromNib()
           
       }
}
