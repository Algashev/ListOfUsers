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
    
    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: "\(cellClass.self)", for: indexPath) as? T
    }
}
