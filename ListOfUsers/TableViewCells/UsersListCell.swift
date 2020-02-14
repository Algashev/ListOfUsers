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
            self.isActiveLabel.textColor = user.isActive ? #colorLiteral(red: 0, green: 0.4833333333, blue: 1, alpha: 1) : #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            self.backgroundColor = user.isActive ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.9601849914, green: 0.9601849914, blue: 0.9601849914, alpha: 1)
            self.accessoryType = user.isActive ? .disclosureIndicator : .none
            if let constraint = self.horizontalStackViewTrailingConstraint {
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
    
    private class UsersListStackView: UIStackView {
        convenience init(axis: NSLayoutConstraint.Axis) {
            self.init()
            self.translatesAutoresizingMaskIntoConstraints = false
            self.axis = axis
        }
    }
    
    private let verticalStackView = UsersListStackView(axis: .vertical)
    private let horizontalStackView = UsersListStackView(axis: .horizontal)
    
    private var horizontalStackViewTrailingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.horizontalStackView)
        
        self.horizontalStackView.addArrangedSubviews(
            [self.verticalStackView, self.isActiveLabel]
        )
        self.verticalStackView.addArrangedSubviews(
            [self.nameLabel, self.emailLabel]
        )
        
        self.horizontalStackView.addConstraint(.centerY, equalTo: self.contentView)
        self.horizontalStackView.addConstraint(.leading, equalTo: self.contentView, constant: 20)
        self.horizontalStackViewTrailingConstraint = self.horizontalStackView.addConstraint(.trailing, equalTo: self.contentView, constant: -20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
