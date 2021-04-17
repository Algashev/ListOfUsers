//
//  UsersListProtocols.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

protocol UsersListViewProtocol: class {
    
    // MARK: - NavigationItems
    
    var navigationItem: UINavigationItem { get }
    func setNavigationBarBackItemTitle(_ title: String?)
    
    // MARK: - RefreshBarButton
    
    func setRefreshBarButtonItem()
    func refreshButtonTapped()
    
    // MARK: - TableView
    
    var tableViewRowHeight: CGFloat { get set }
    
    func register(_ cellClass: AnyClass)
    func reloadTable()
}

protocol UsersListPresenterProtocol: class {
    var router: UsersListRouterProtocol! { get set }
    func configureView()
    func reloadUsers()
    var numberOfRows: Int { get }
    func userCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell?
    func reloadDataFromServer()
    func didSelectUser(atRow row: Int)
}

protocol UsersListInteractorProtocol: class {
    var navigationItemTitle: String { get }
    var navigationBarBackItemTitle: String? { get }
    var numberOfUsers: Int { get }
    func getUsersList()
    func user(forCellAt row: Int) -> User
    func reloadDataFromServer()
    func isActiveUser(atRow row: Int) -> Bool
}

protocol UsersListRouterProtocol: class {
    func showUserDetails(atRow row: Int)
}

protocol UsersListConfiguratorProtocol: class {
    func configure(with tableViewController: UsersListTableViewController)
}
