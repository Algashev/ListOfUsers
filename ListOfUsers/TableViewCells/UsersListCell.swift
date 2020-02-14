//
//  UsersListCell.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 19/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UsersListCell: UITableViewCell {
    var user: User? {
        didSet {
            guard let user = self.user else { return }
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            self.isActiveLabel.text = user.isActive ? "Active" : "Inactive"
            self.isActiveLabel.textColor = user.isActive ? #colorLiteral(red: 0, green: 0.4833333333, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.backgroundColor = user.isActive ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.9601849914, green: 0.9601849914, blue: 0.9601849914, alpha: 1)
            self.accessoryType = user.isActive ? .disclosureIndicator : .none
            if let constraint = self.isActiveLabelTrailingConstraint {
                constraint.constant = user.isActive ? -10 : -20
                self.contentView.updateConstraintsIfNeeded()
            }
        }
    }
    
    private class UsersListLabel: UILabel {
        convenience init(textStyle: UIFont.TextStyle, textAlignment: NSTextAlignment = .left, textColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) {
            self.init()
            self.translatesAutoresizingMaskIntoConstraints = false
            self.font = .preferredFont(forTextStyle: textStyle)
            self.textAlignment = textAlignment
            self.textColor = textColor
        }
    }
    
    private let nameLabel = UsersListLabel(textStyle: .headline)
    private let emailLabel = UsersListLabel(textStyle: .footnote, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let isActiveLabel = UsersListLabel(textStyle: .subheadline, textAlignment: .right)
    
    private var isActiveLabelTrailingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(emailLabel)
        self.contentView.addSubview(isActiveLabel)
        
        self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        
        self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        self.emailLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor).isActive = true
        self.emailLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5
            ).isActive = true
        self.emailLabel.trailingAnchor.constraint(equalTo: self.isActiveLabel.leadingAnchor, constant: -6).isActive = true
        
//        self.isActiveLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor).isActive = true
        self.isActiveLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.isActiveLabelTrailingConstraint = NSLayoutConstraint(
            item: self.isActiveLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.contentView,
            attribute: .trailing,
            multiplier: 1,
            constant: -20)
        if let constraint = self.isActiveLabelTrailingConstraint {
            self.contentView.addConstraint(constraint)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
