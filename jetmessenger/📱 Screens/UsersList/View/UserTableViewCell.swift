//
//  UserTableViewCell.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit

final class UserTableViewCell: BaseTableViewCell, FillableProtocol {
    
    typealias DataType = ViewModel
    struct ViewModel {
        let name: String
        let state: String
        let image: String
    }
    
    // MARK: - IBOutlets 🔌
    @IBOutlet private weak var userStateView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!

    
    // MARK: - LifeCycle 🌏
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //
    func fill(_ data: DataType) {
        userNameLabel.text = data.name
        // userImageView.image = data.image
    }
}
