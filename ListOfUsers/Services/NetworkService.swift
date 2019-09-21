//
//  NetworkService.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol: class {
    func getUsersFromJSON(completion: @escaping ([User]) -> ())
}

class NetworkService: NetworkServiceProtocol {
    private init() { }
    static let shared = NetworkService()
    
    private let sharedSession = URLSession.shared
    private var dataTask: URLSessionDataTask?
    private let url = AppSettings.sourceUrl
    private var users = [User]()
    
    typealias JSONDictionary = [[String: Any]]
    
    func getUsersFromJSON(completion: @escaping ([User]) -> ()) {
        self.dataTask?.cancel()
        guard let url = URL(string: url) else { return }
        dataTask = self.sharedSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                print(error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    guard let jsonDictionary = json as? JSONDictionary else { return }
                    self?.convertToUsersList(from: jsonDictionary)
                    DispatchQueue.main.async {
                        guard let users = self?.users else { return }
                        completion(users)
                    }
                } catch {
                    print(error)
                    return
                }
            }
        }
        dataTask?.resume()
    }
    
    private func convertToUsersList(from jsonDictionary: JSONDictionary) {
        for user in jsonDictionary {
            guard
                let id = user["id"] as? Int,
                let guid = user["guid"] as? String,
                let isActive = user["isActive"] as? Bool,
                let balance = user["balance"] as? String,
                let age = user["age"] as? Int,
                let eyeColorString = user["eyeColor"] as? String,
                let eyeColor = EyeColor(rawValue: eyeColorString),
                let name = user["name"] as? String,
                let genderString = user["gender"] as? String,
                let gender = Gender(rawValue: genderString),
                let company = user["company"] as? String,
                let email = user["email"] as? String,
                let phone = user["phone"] as? String,
                let address = user["address"] as? String,
                let about = user["about"] as? String,
                let registered = user["registered"] as? String,
                let latitude = user["latitude"] as? Double,
                let longitude = user["longitude"] as? Double,
                let tags = user["tags"] as? [String],
                let friends = user["friends"] as? [[String : Int]],
                let favoriteFruitString = user["favoriteFruit"] as? String,
                let favoriteFruit = FavoriteFruit(rawValue: favoriteFruitString) else { continue }
            let user = User(
                id: id,
                guid: guid,
                isActive: isActive,
                balance: balance,
                age: age,
                eyeColor: eyeColor,
                name: name,
                gender: gender,
                company: company,
                email: email,
                phone: phone,
                address: address,
                about: about,
                registered: registered,
                latitude: latitude,
                longitude: longitude,
                tags: tags,
                friends: friends,
                favoriteFruit: favoriteFruit)
            self.users += [user]
        }
    }
}
