//
//  UIView.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 14.02.2020.
//  Copyright © 2020 Александр Алгашев. All rights reserved.
//

import UIKit

extension UIView {
    func constraint(_ attribute: NSLayoutConstraint.Attribute, equalTo view: Any, constant c: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: c)
    }
    
    @discardableResult
    func addConstraint(_ attribute: NSLayoutConstraint.Attribute, equalTo view: Any, constant c: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = self.constraint(attribute, equalTo: view, constant: c)
        constraint.activate()
        return constraint
    }
    
    func sizeConstraints(_ size: CGSize) -> (widthAnchor: NSLayoutConstraint, heightAnchor: NSLayoutConstraint) {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
        return (widthConstraint, heightConstraint)
    }
    
    @discardableResult
    func addSizeConstraints(_ size: CGSize) -> (widthAnchor: NSLayoutConstraint, heightAnchor: NSLayoutConstraint) {
        let constraints = self.sizeConstraints(size)
        constraints.widthAnchor.activate()
        constraints.heightAnchor.activate()
        return constraints
    }
}
