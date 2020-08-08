//
//  UIWindow.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 08.08.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import UIKit

extension UIWindow {
    convenience init(rootViewController: UIViewController) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = rootViewController
        self.makeKeyAndVisible()
    }
}
