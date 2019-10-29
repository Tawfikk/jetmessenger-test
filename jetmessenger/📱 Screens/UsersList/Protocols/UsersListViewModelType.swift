//
//  UsersListViewModelType.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

protocol UsersListViewModelInput: class {
    func refresh()
    
    var loadPageTrigger: PublishSubject<Void> { get }
    var loadNextPageTrigger: PublishSubject<Void> { get }
}

protocol UsersListViewModelOutput: class {
    var isLoading: Observable<Bool> { get }
    var isMoreLoading: Observable<Bool> { get }
    var errorMessage: PublishSubject<String> { get }
    
    var membersList: BehaviorRelay<[MembersModelList]> { get }
}

protocol UsersListViewModelType: class {
    var input: UsersListViewModelInput { get }
    var output: UsersListViewModelOutput { get }
}

extension UsersListViewModelType where Self: UsersListViewModelInput & UsersListViewModelOutput {
    var input: UsersListViewModelInput { return self }
    var output: UsersListViewModelOutput { return self }
}
