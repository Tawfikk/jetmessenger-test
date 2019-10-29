//
//  UsersListViewController.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class UsersListViewController: UIViewController {
    
    var viewModel: UsersListViewModel!
    private var refreshController = UIRefreshControl()
    
    // MARK: - Outlets 🔌
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - LifeCycle 🌎
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        title = "Контакты"
    }
}

// MARK: - TableView Binding
extension UsersListViewController {
    func tableViewBinding() {
        viewModel.output.membersList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: UserTableViewCell.identifier, cellType: UserTableViewCell.self)) { row, item, cell in
                let model = UserTableViewCell.ViewModel(name: item.name, state: item.status, image: "")
        }.disposed(by: bag)
    }
}

// MARK: - Setup 🛠
private extension UsersListViewController {
    func setup() {
        tableViewConfigure()
        
        tableViewBinding()
        viewModelSubscribe()
    }
    
    func viewModelSubscribe() {
        viewModel.input.refresh()
        
        refreshController.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.loadPageTrigger)
            .disposed(by: bag)
        
        tableView.rx.reachedBottom
            .observeOn(ConcurrentMainScheduler.instance)
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: bag)
        
        viewModel.output.isLoading
            .observeOn(MainScheduler.instance)
            .do(onNext: { isLoading in
                if isLoading {
                    self.refreshController.endRefreshing()
                }
            })
            .bind(to: isLoading(for: self.view!))
            .disposed(by: bag)
    }
    
    func tableViewConfigure() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100.0
        tableView.addSubview(refreshController)
        tableView.registerNib(UserTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
    }
}
