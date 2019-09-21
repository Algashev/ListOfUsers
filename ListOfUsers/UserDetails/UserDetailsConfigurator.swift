//
//  UserDetailsConfigurator.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UserDetailsConfigurator: UserDetailsConfiguratorProtocol {
    func configure(with tableViewController: UserDetailsTableViewController) {
        let presenter = UserDetailsPresenter(view: tableViewController)
        let interactor = UserDetailsInteractor(presenter: presenter)
        let router = UserDetailsRouter(tableViewController: tableViewController)
        
        tableViewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
