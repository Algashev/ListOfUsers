//
//  UsersListPresenter.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UsersListPresenter: UsersListPresenterProtocol {
    weak var view: UsersListViewProtocol!
    var interactor: UsersListInteractorProtocol!
    var router: UsersListRouterProtocol!
    
    required init(view: UsersListViewProtocol) {
        self.view = view
    }
    
    private var navigationItemTitle: String { interactor.navigationItemTitle }
    private var navigationBarBackItemTitle: String? { interactor.navigationBarBackItemTitle }
    
    // MARK: - UsersListPresenterProtocol methods
    
    func configureView() {
        self.view.navigationItem.title = self.navigationItemTitle
        self.view.setNavigationBarBackItemTitle(self.navigationBarBackItemTitle)
        self.view.setRefreshBarButtonItem()
        self.view.tableViewRowHeight = 50
        self.view.register(UserCell.self)
        self.interactor.getUsersList()
    }
    
    func loadUsersInTable() {
        self.view.reloadTable()
    }
    
    var numberOfRows: Int {
        return self.interactor.numberOfUsers
    }
    
    func userCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(UserCell.self, for: indexPath)
        cell?.user = self.interactor.user(forCellAt: indexPath.row)
        return cell
    }
    
    func reloadDataFromServer() {
        self.interactor.reloadDataFromServer()
    }
    
    func didSelectUser(atRow row: Int) {
        if self.interactor.isActiveUser(atRow: row) {
            self.router.showUserDetails(atRow: row)
        }
    }
}
