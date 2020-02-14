//
//  UserDetailsProtocols.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

protocol UserDetailsViewProtocol: class {
    var userId: Int { get set }
    func setNavigationItemTitle(with value: String)
    func setNavigationBarBackItemTitle(with value: String)
    func register(cellClass: AnyClass?, forCellReuseIdentifier Identifier: String)
    init(withUserId id: Int)
}

protocol UserDetailsPresenterProtocol: class {
    var router: UserDetailsRouterProtocol! { set get }
    func configureView()
    func getNumberOfSections() -> Int
    func getNumberOfRows(InSection section: Int) -> Int
    func getTitleForHeader(InSection section: Int) -> String?
    func cellForUserDetails(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func didSelectIndexPath(_ indexPath: IndexPath)
}

protocol UserDetailsInteractorProtocol: class {
    func navigationItemTitleFor(userId: Int) -> String
    var navigationBarBackItemTitle: String { get }
    func getUsersList()
    func getUser(withId userId: Int) -> User
}

protocol UserDetailsRouterProtocol: class {
    func showUserDetails(ForId userId: Int)
    func sendEmailTo(user: User)
    func makeCallTo(user: User)
    func openMapWithLocationOf(user: User)
}

protocol UserDetailsConfiguratorProtocol: class {
    func configure(with tableViewController: UserDetailsTableViewController)
}
