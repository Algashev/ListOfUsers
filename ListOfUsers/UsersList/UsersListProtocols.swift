//
//  UsersListProtocols.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

protocol UsersListViewProtocol: class {
    var navigationItem: UINavigationItem { get }
    
    func setNavigationBarBackItemTitle(_ title: String)
    func setRefreshBarButtonItem()
    func refreshButtonTapped()
    func setTableViewRowHeight(with value: CGFloat)
    func register(_ cellClass: AnyClass)
    func reloadTable()
}

protocol UsersListPresenterProtocol: class {
    var router: UsersListRouterProtocol! { set get }
    func configureView()
    func loadUsersInTable()
    var numberOfRows: Int { get }
    func usersListCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell?
    func reloadDataFromServer()
    func didSelectRow(_ row: Int)
}

protocol UsersListInteractorProtocol: class {
    var navigationItemTitle: String { get }
    var navigationBarBackItemTitle: String { get }
    var numberOfUsers: Int { get }
    func getUsersList()
    func user(forCellAt row: Int) -> User
    func reloadDataFromServer()
    func isActiveUserAtRow(_ row: Int) -> Bool
}

protocol UsersListRouterProtocol: class {
    func showUserDetailsForRow(_ row: Int)
}

protocol UsersListConfiguratorProtocol: class {
    func configure(with tableViewController: UsersListTableViewController)
}
