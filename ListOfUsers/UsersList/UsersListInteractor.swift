//
//  UsersListInteractor.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UsersListInteractor: UsersListInteractorProtocol {
    weak var presenter: UsersListPresenterProtocol!
    var usersService: UsersServiceProtocol = UsersService.shared
    
    required init(presenter: UsersListPresenterProtocol) {
        self.presenter = presenter
        self.usersService.delegate = self
    }
    
    // MARK: - UsersListInteractorProtocol methods
    
    var navigationItemTitle: String { return "List Of Users" }
    var navigationBarBackItemTitle: String { return "" }
    
    func getUsersList() {
        self.usersService.getUsers(isForcedFromServer: false)
    }
    
    var numberOfUsers: Int {
        return self.usersService.users.count
    }
    
    func user(forCellAt row: Int) -> User {
        return self.usersService.users[row]
    }
    
    func reloadDataFromServer() {
        self.usersService.getUsers(isForcedFromServer: true)
    }
    
    func isActiveUserAtRow(_ row: Int) -> Bool {
        return self.usersService.users[row].isActive
    }
}

extension UsersListInteractor: UsersServiceDelegate {
    func dataReadyForUse() {
        self.presenter.loadUsersInTable()
    }
}
