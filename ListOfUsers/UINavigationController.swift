//
//  UINavigationController.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

extension UINavigationController {
    @discardableResult
    convenience init(for appDelegate: AppDelegate, with controller: UIViewController) {
        self.init()
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        self.viewControllers = [controller]
        guard let window = appDelegate.window else { return }
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
}
