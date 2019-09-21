//
//  UsersService.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 19/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

protocol UsersServiceProtocol {
    var users: [User] { get set }
    var delegate: UsersServiceDelegate? { get set }
    func getUsers(isForcedFromServer: Bool)
}

protocol UsersServiceDelegate: class {
    func dataReadyForUse()
}

class UsersService: UsersServiceProtocol {
    private init() { }
    static let shared = UsersService()
    
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private let storageService: StorageServiceProtocol = StorageService.shared
    private var timer = RepeatingTimer(timeInterval: AppSettings.dataRefreshingTimeInterval)
    private var isNeedUpdateData: Bool {
        get {
            return Date() > Date(timeInterval: AppSettings.dataRefreshingTimeInterval, since: self.storageService.dateOfSaving)
        }
    }
    weak var delegate: UsersServiceDelegate?
    var users = [User]()
    
    private func getUsersFromServer() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        networkService.getUsersFromJSON { (users) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if self.users != users {
                self.users = users
                self.storageService.removeOldData()
                self.storageService.save(users)
            }
            self.delegate?.dataReadyForUse()
        }
    }
    
    func getUsers(isForcedFromServer: Bool) {
        if !self.storageService.isExistSavedData || self.isNeedUpdateData || isForcedFromServer {
            self.getUsersFromServer()
            print("Request from server: \(Date())")
            if !timer.isCancelled && self.timer.eventHandler != nil {
                self.timer.cancel()
                self.timer = RepeatingTimer(timeInterval: AppSettings.dataRefreshingTimeInterval)
            }
            self.timer.eventHandler = { [unowned self] in
                print("Timer Fired: \(Date())")
                self.getUsersFromServer()
            }
            self.timer.resume()
        } else {
            print("Request saved data: \(Date())")
            if self.users.isEmpty {
                self.users = self.storageService.getSavedData()
            }
            self.delegate?.dataReadyForUse()
        }
    }
}
