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
    
    private var navigationItemTitle: String { return interactor.navigationItemTitle }
    private var navigationBarBackItemTitle: String { return interactor.navigationBarBackItemTitle }
    
    // MARK: - UsersListPresenterProtocol methods
    
    func configureView() {
        self.view.setNavigationItemTitle(with: self.navigationItemTitle)
        self.view.setNavigationBarBackItemTitle(with: self.navigationBarBackItemTitle)
        self.view.setRefreshBurButtonitem()
        self.view.setTableViewRowHeight(with: 50)
        self.view.register(UsersListCell.self)
        self.interactor.getUsersList()
    }
    
    func loadUsersInTable() {
        self.view.reloadTable()
    }
    
    var numberOfRows: Int {
        return self.interactor.numberOfUsers
    }
    
    func usersListCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(UsersListCell.self, for: indexPath)
        cell?.user = self.interactor.user(forCellAt: indexPath.row)
        return cell
    }
    
    func reloadDataFromServer() {
        self.interactor.reloadDataFromServer()
    }
    
    func didSelectRow(_ row: Int) {
        if self.interactor.isActiveUserAtRow(row) {
            self.router.showUserDetailsForRow(row)
        }
    }
}
