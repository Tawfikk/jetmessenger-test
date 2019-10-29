//
//  UserTableViewCell.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit
import Kingfisher

enum UserState: String {
    case online = "online"
    case offline = "offline"
    case unknow
}

final class UserTableViewCell: BaseTableViewCell, FillableProtocol {
    
    typealias DataType = ViewModel
    struct ViewModel {
        let name: String
        let state: String
        let userName: String
    }
    
    // MARK: - IBOutlets 🔌
    @IBOutlet private weak var userStateView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var imageLoadActivity: UIActivityIndicatorView!
    
    
    // MARK: - LifeCycle 🌏
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    //
    func fill(_ data: DataType) {
        setUserState(data.state)
        userNameLabel.text = data.name
        imageLoadActivity.startAnimating()
        userImageView.kf.setImage(with: data.userName.getAvatar(), placeholder: UIImage.Icons.userAvatar) { [weak self] _ in
            self?.imageLoadActivity.stopAnimating()
        }        
    }
}

// MARK: - Setup 🛠
private extension UserTableViewCell {
    func setup() {
        viewsConfigure()
    }
    
    func viewsConfigure() {
        userStateView.round()
        userImageView.round()
    }
    
    func setUserState(_ value: String) {
        let state: UserState = UserState(rawValue: value) ?? .unknow
        switch state {
        case .online:
            userStateView.isHidden = false
            userStateView.layer.borderWidth = 1.0
            userStateView.layer.borderColor = UIColor.white.cgColor
            userStateView.layer.backgroundColor = UIColor.green.cgColor
        case .offline:
            userStateView.isHidden = false
            userStateView.layer.borderWidth = 1.0
            userStateView.layer.borderColor = UIColor.white.cgColor
            userStateView.layer.backgroundColor = UIColor.orange.cgColor
        case .unknow:
            userStateView.isHidden = true
        }
    }
}
