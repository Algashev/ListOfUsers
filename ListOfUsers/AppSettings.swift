//
//  AppSettings.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 20/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import Foundation

struct AppSettings {
    static let sourcePath = "https://www.dropbox.com/s/s8g63b149tnbg8x/users.json?raw=1"
    static let refreshingInterval: TimeInterval = 5.minutes
    static let storageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Users.plist")
}
