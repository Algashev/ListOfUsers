//
//  UserDetailsTableViewController.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit
import MessageUI

class UserDetailsTableViewController: UITableViewController, UserDetailsViewProtocol {
    
    var userId: Int
    var presenter: UserDetailsPresenterProtocol!
    let configurator: UserDetailsConfiguratorProtocol = UserDetailsConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
//        tableView.estimatedRowHeight = 44

    }
    
    required init(withUserId id: Int) {
        self.userId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavigationItemTitle(with value: String) {
        self.navigationItem.title = value
    }
    
    func setNavigationBarBackItemTitle(with value: String) {
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: value, style: .plain, target: nil, action: nil)
    }
    
    func register(cellClass: AnyClass?, forCellReuseIdentifier Identifier: String) {
        self.tableView.register(cellClass, forCellReuseIdentifier: Identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.getNumberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.presenter.getTitleForHeader(InSection: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter.getNumberOfRows(InSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        return self.presenter.cellForUsersList(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectIndexPath(indexPath)
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

extension UserDetailsTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
