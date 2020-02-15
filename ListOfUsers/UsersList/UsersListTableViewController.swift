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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()

    }
    
    func setNavigationItemTitle(with value: String) {
        self.navigationItem.title = value
    }
    
    func setNavigationBarBackItemTitle(with value: String) {
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: value, style: .plain, target: nil, action: nil)
    }
    
    func setRefreshBurButtonitem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    }
    
    func setTableViewRowHeight(with value: CGFloat) {
        tableView.rowHeight = value
    }
    
    func register(_ cellClass: AnyClass) {
        self.tableView.register(cellClass)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter.getNumberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        return self.presenter.cellForUsersList(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRow(indexPath.row)
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    @objc func refreshButtonTapped() {
        self.presenter.reloadDataFromServer()
    }

    func reloadTable() {
        self.tableView.reloadData()
    }
}
