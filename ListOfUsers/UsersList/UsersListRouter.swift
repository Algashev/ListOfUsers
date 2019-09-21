//
//  UsersListRouter.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UsersListRouter: UsersListRouterProtocol {
    weak var tableViewController: UsersListTableViewController!
    
    init(tableViewController: UsersListTableViewController) {
        self.tableViewController = tableViewController
    }
    
    func showUserDetailsForRow(_ row: Int) {
        self.tableViewController.navigationController?.pushViewController(UserDetailsTableViewController(withUserId: row), animated: true)
    }
}
