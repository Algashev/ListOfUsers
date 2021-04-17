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
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func setNavigationBarBackItemTitle(_ title: String) {
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = barButtonItem
    }
    
    func setRefreshBarButtonItem() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func register(_ cellClass: AnyClass) {
        self.tableView.register(cellClass)
    }
    
    @objc func refreshButtonTapped() {
        self.presenter.reloadDataFromServer()
    }

    func reloadTable() {
        self.tableView.reloadData()
    }
}

// MARK: - TableView Delegate

extension UsersListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.presenter.userCell(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRow(indexPath.row)
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}
