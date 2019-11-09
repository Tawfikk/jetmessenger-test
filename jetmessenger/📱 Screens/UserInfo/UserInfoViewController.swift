//
//  UserInfoViewController.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

final class UserInfoViewController: UIViewController {
    
    var viewModel: UserInfoViewModelType!
    
    // MARK: - Outlets 🔌
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userStatusLabel: UILabel!
    @IBOutlet private weak var userNicknameLabel: UILabel!
    @IBOutlet private weak var userAvatarImageView: UIImageView!
    
    
    // MARK: - LifeCycle 🌎
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        title = "Контакт"
    }
}

// MARK: - Setup 🛠
private extension UserInfoViewController {
    func setup() {
        viewModelSubscribe()
    }
    
    func viewModelSubscribe() {
        viewModel.output.selectedUser.subscribe(onNext: { model in
            guard let model = model else { return }
            self.userNameLabel.text = model.name
            self.userNicknameLabel.text = model.userName
            self.userStatusLabel.text = model.statusText
            
            self.userAvatarImageView.kf.setImage(with: model.userName?.getAvatar(), placeholder: UIImage.Icons.userAvatar)
        }).disposed(by: bag)
    }
}
