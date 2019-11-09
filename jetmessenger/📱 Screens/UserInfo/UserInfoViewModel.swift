//
//  UserInfoViewModel.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class UserInfoViewModel: UserInfoViewModelType {
    
    // MARK: - Private properties 🕶
    private var userID: String
    private let bag = DisposeBag()
    
    // MARK: - Visible properties 👓
    var dataProvider: DataProvider
    var selectedUser: BehaviorRelay<MembersModelList?>
    
    // MARK: - Constructor 🏗
    init(userID: String, dataProvider: DataProvider) {
        self.userID = userID
        self.dataProvider = dataProvider
        
        selectedUser = BehaviorRelay<MembersModelList?>(value: nil)
        dataProvider.obtainUser(by: userID).bind(to: selectedUser).disposed(by: bag)
    }
}

// MARK: -
extension UserInfoViewModel: UserInfoViewModelInput, UserInfoViewModelOutput {
    
}
