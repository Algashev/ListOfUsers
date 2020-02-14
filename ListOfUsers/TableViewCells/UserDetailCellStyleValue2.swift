//
//  UserDetailCellStyleValue2.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 21/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit
import CoreLocation

class UserDetailCellStyleValue2: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(user: User, andCellType cellType: UserDetailCellType) {
        switch cellType {
        case .age:
            self.textLabel?.text = "age"
            self.detailTextLabel?.text = String(describing: user.age)
        case .eyeColor:
            self.textLabel?.text = "eye color"
            self.detailTextLabel?.text = String(describing: user.eyeColor)
        case .company:
            self.textLabel?.text = "company"
            self.detailTextLabel?.text = String(describing: user.company)
        case .email:
            self.textLabel?.text = "email"
            self.detailTextLabel?.text = String(describing: user.email)
        case .phone:
            self.textLabel?.text = "phone"
            self.detailTextLabel?.text = String(describing: user.phone)
        case .address:
            self.textLabel?.text = "address"
            self.detailTextLabel?.numberOfLines = 0
            self.detailTextLabel?.text = String(describing: user.address)
        case .location:
            self.textLabel?.text = "location"
            self.detailTextLabel?.text = self.convertDoublesToDegreesCoordinates(latitude: user.latitude, longitude: user.longitude)
        case .balance:
            self.textLabel?.text = "balance"
            self.detailTextLabel?.text = self.dropZeroFractionFrom(user.balance)
        case .registered:
            self.textLabel?.text = "registered"
            self.detailTextLabel?.text = user.registered.format("HH:mm dd.MM.yy")
        case .favoriteFruit:
            self.textLabel?.text = "favorite fruit"
            self.detailTextLabel?.text = user.favoriteFruit.emoji
        case .about:
            self.textLabel?.text = "about"
            self.detailTextLabel?.numberOfLines = 0
            self.detailTextLabel?.text = String(describing: user.about)
        case .tags:
            self.textLabel?.text = "tags"
            self.detailTextLabel?.numberOfLines = 0
            self.detailTextLabel?.text = String(describing: user.tags)
        case .friends:
            self.textLabel?.text = "friends"
            self.detailTextLabel?.numberOfLines = 0
            self.detailTextLabel?.text = String(describing: user.friends)
        }
    }
    
    private func convertDoublesToDegreesCoordinates(latitude: Double, longitude: Double) -> String {
        var longitudeString = longitude > 0 ? "E" : "W"
        longitudeString += self.convertToDegreesFromDouble(longitude)
        var latitudeString = latitude > 0 ? "N" : "S"
        latitudeString += self.convertToDegreesFromDouble(latitude)
        return "\(longitudeString) \(latitudeString)"
    }
    
    private func convertToDegreesFromDouble(_ value: Double) -> String {
        var value = abs(value)
        let degrees = floor(value)
        value = (value - degrees) * 60
        let minutes = floor(value)
        value = (value - minutes) * 60
        let seconds = floor(value)
        return "\(Int(degrees))°\(Int(minutes).format("%02d"))′\(Int(seconds).format("%02d"))″"
    }
    
    private func dropZeroFractionFrom(_ value: String) -> String {
        let array = value.split(separator: ".")
        guard
            let fraction = array.last,
            let integer = array.first
        else { return value }
        return Int(fraction) == 0 ? String(integer) : value
    }
}
