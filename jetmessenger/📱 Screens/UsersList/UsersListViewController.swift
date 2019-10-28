//
//  UsersListViewController.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit

final class UsersListViewController: UIViewController {
    
    var viewModel: UsersListViewModel!
    
    // MARK: - Outlets 🔌
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - LifeCycle 🌎
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Setup 🛠
private extension UsersListViewController {
    func setup() {
        
    }
}

