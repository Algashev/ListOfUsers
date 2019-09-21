//
//  StorageService.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 20/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import Foundation

protocol StorageServiceProtocol: class {
    var isExistSavedData: Bool { get }
    var dateOfSaving: Date { get }
    func save(_ users: [User])
    func removeOldData()
    func getSavedData() -> [User]
}

class StorageService: StorageServiceProtocol {
    private init() { }
    static let shared = StorageService()
    
    var isExistSavedData: Bool {
        return FileManager.default.fileExists(atPath: AppSettings.savedDataPath.path)
    }
    var dateOfSaving: Date {
        return UserDefaults.standard.object(forKey: "dateOfSaving") as? Date ?? Date(timeIntervalSince1970: 0)
    }
    
    func save(_ users: [User]) {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(users)
            try data.write(to: AppSettings.savedDataPath)
            UserDefaults.standard.set(Date(), forKey: "dateOfSaving")
        } catch {
            print(error)
        }
    }
    
    func removeOldData() {
        guard self.isExistSavedData else { return }
        do {
            try FileManager.default.removeItem(at: AppSettings.savedDataPath)
        } catch {
            print(error)
        }
    }
    
    func getSavedData() -> [User] {
        do {
            let data = try Data(contentsOf: AppSettings.savedDataPath)
            let decoder = PropertyListDecoder()
            let users = try decoder.decode([User].self, from: data)
            return users
        } catch {
            print(error)
        }
        return []
    }
}
