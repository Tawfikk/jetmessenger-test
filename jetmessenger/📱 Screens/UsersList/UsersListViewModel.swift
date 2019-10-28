//
//  UsersListViewModel.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UsersListViewModel {
    
    // MARK: - Private properties 🕶
    
    // MARK: - Visible properties 👓
    var membersList = BehaviorRelay<[MembersModelList]>(value: [])
    
    // MARK: - Constructor 🏗
    init() {
    }
}

