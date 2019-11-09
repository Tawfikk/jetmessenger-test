//
//  UserInfoViewModelType.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RxCocoa

protocol UserInfoViewModelInput: class {}
protocol UserInfoViewModelOutput: class {
    var dataProvider: DataProvider { get }
    var selectedUser: BehaviorRelay<MembersModelList?> { get }
}

protocol UserInfoViewModelType: class {
    var input: UserInfoViewModelInput { get }
    var output: UserInfoViewModelOutput { get }
}

extension UserInfoViewModelType where Self: UserInfoViewModelInput & UserInfoViewModelOutput {
    var input: UserInfoViewModelInput { return self }
    var output: UserInfoViewModelOutput { return self }
}
