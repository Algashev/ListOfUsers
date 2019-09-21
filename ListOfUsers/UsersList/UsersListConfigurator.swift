//
//  UsersListConfigurator.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UsersListConfigurator: UsersListConfiguratorProtocol {
    func configure(with tableViewController: UsersListTableViewController) {
        let presenter = UsersListPresenter(view: tableViewController)
        let interactor = UsersListInteractor(presenter: presenter)
        let router = UsersListRouter(tableViewController: tableViewController)
        
        tableViewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
