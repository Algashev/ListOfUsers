//
//  UserDetailsInteractor.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UserDetailsInteractor: UserDetailsInteractorProtocol {
    weak var presenter: UserDetailsPresenterProtocol!
    var usersService: UsersServiceProtocol = UsersService.shared
    
    required init(presenter: UserDetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - UserDetailsInteractorProtocol methods
    
    var navigationBarBackItemTitle: String { return "" }
    
    func navigationItemTitleFor(userId: Int) -> String {
        return self.usersService.users[userId].name
    }
    
    func getUsersList() {
        self.usersService.getUsers(isForcedFromServer: false)
    }
    
    func getUser(withId userId: Int) -> User {
        return self.usersService.users[userId]
    }
}
