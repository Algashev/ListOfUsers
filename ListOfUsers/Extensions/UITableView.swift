//
//  UITableView.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 15.02.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: "\(cellClass.self)")
    }
}
