//
//  UserDetailsRouter.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit
import MessageUI
import MapKit

class UserDetailsRouter: UserDetailsRouterProtocol {
    weak var tableViewController: UserDetailsTableViewController!
    
    init(tableViewController: UserDetailsTableViewController) {
        self.tableViewController = tableViewController
    }
    
    func showUserDetails(ForId userId: Int) {
        self.tableViewController.navigationController?.pushViewController(UserDetailsTableViewController(withUserId: userId), animated: true)
    }
    
    func sendEmailTo(user: User) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self.tableViewController
            mail.setToRecipients([user.email])
            mail.setMessageBody("<p>Dear \(user.name)</p>", isHTML: true)
            
            self.tableViewController.present(mail, animated: true)
        }
        
//        if let url = URL(string: "mailto:\(user.email)") { UIApplication.shared.open(url) }
    }
    
    func makeCallTo(user: User) {
        if let url = URL(string: "tel://\(user.phone.filter { Int(String($0)) != nil })") {
            print("phone")
            UIApplication.shared.open(url) }
    }
    
    func openMapWithLocationOf(user: User) {
        let latitude: CLLocationDegrees = user.latitude
        let longitude: CLLocationDegrees = user.longitude
        print("latitude:\(user.latitude) longitude:\(user.longitude)")
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = user.name
        mapItem.phoneNumber = user.phone
        mapItem.openInMaps(launchOptions: options)
    }
}
