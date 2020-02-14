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
    convenience init(with controller: UIViewController) {
        self.init()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate?.window?.rootViewController = self
        appDelegate?.window?.makeKeyAndVisible()
        self.viewControllers = [controller]
    }
}
