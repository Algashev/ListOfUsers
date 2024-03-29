//
//  UsersListTableViewController.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UsersListTableViewController: UITableViewController, UsersListViewProtocol {
    var presenter: UsersListPresenterProtocol!
    let configurator: UsersListConfiguratorProtocol = UsersListConfigurator()
    
    var tableViewRowHeight: CGFloat {
        get { self.tableView.rowHeight }
        set { self.tableView.rowHeight = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurator.configure(with: self)
        self.presenter.configureView()
    }
    
    func setNavigationBarBackItemTitle(_ title: String?) {
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = barButtonItem
    }
    
    // MARK: - RefreshBarButton
    
    func setRefreshBarButtonItem() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func refreshButtonTapped() {
        self.presenter.reloadDataFromServer()
    }
    
    // MARK: - TableView
    
    func register(_ cellClass: AnyClass) {
        self.tableView.register(cellClass)
    }

    func reloadTable() {
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

// MARK: - TableView Delegate

extension UsersListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.presenter.userCell(at: indexPath, in: tableView) ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectUser(atRow: indexPath.row)
    }
}
