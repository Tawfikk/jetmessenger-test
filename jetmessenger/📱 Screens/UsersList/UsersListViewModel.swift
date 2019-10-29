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

final class UsersListViewModel: UsersListViewModelType {
    
    // MARK: - Private properties 🕶
    private let bag = DisposeBag()
    private var pageOffset: Int = 0
    private let dataProvider: DataProvider
    
    // MARK: - Visible properties 👓
    var isLoading: Observable<Bool>
    var isMoreLoading: Observable<Bool>
    
    var errorMessage = PublishSubject<String>()
    var loadPageTrigger = PublishSubject<Void>()
    var loadNextPageTrigger = PublishSubject<Void>()
    
    var membersList = BehaviorRelay<[MembersModelList]>(value: [])
    
    // MARK: - Constructor 🏗
    init(provider: DataProvider) {
        self.dataProvider = provider
        
        let loading = ActivityIndicator()
        self.isLoading = loading.asObservable()
        
        let moreLoading = ActivityIndicator()
        self.isMoreLoading = moreLoading.asObservable()
        
        // First time load
        let loadRequest = self.isLoading.asObservable()
            .sample(self.loadPageTrigger)
            .flatMap { isLoading -> Observable<[MembersModelList]> in
                if isLoading {
                    return Observable.empty()
                } else {
                    self.pageOffset = 0
                    self.membersList.accept([])
                    return self.dataProvider.obtainMembers(offset: self.pageOffset).trackActivity(loading)
                }
        }
        
        // Get more data by page
        let loadMoreRequest = self.isMoreLoading.asObservable()
            .sample(self.loadNextPageTrigger)
            .flatMap { isLoading -> Observable<[MembersModelList]> in
                if isLoading {
                    return Observable.empty()
                } else {
                    self.pageOffset += 1
                    return self.dataProvider.obtainMembers(offset: self.pageOffset).trackActivity(moreLoading)
                }
        }
        
        let request = Observable.of(loadRequest, loadMoreRequest)
            .merge()
            .share(replay: 1)
        
        let response = request.flatMap { members -> Observable<[MembersModelList]> in
            request.do(onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            }).catchError { error -> Observable<[MembersModelList]> in
                Observable.empty()
            }
        }.share(replay: 1)
                
        // Combine data when get more data by paging
        Observable.combineLatest(request, response, membersList.asObservable()) { request, response, members in
            return self.pageOffset == 1 ? response : members + response
        }
        .sample(response)
        .bind(to: membersList)
        .disposed(by: bag)
    }
}

// MARK: - UsersListViewModelInput
extension UsersListViewModel: UsersListViewModelInput {
    func refresh() {
        self.loadPageTrigger.onNext(())
    }
}

// MARK: - UsersListViewModelOutput
extension UsersListViewModel: UsersListViewModelOutput {
    
}
