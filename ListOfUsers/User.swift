//
//  User.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import Foundation

enum EyeColor: String, Codable {
    case brown, green, blue
}

enum Gender: String, Codable {
    case male, female
}

enum FavoriteFruit: String, Codable {
    case apple, banana, strawberry
}

struct User: Codable, Equatable {
    let id: Int
    let guid: String
    let isActive: Bool
    let balance: String
    let age: Int
    let eyeColor: EyeColor
    let name: String
    let gender: Gender
    let company: String
    let email: String
    let phone: String
    let address: String
    let about: String
    let registered: Date
    let latitude: Double
    let longitude: Double
    let tags: [String]
    let friends: [[String : Int]]
    let favoriteFruit: FavoriteFruit
}
