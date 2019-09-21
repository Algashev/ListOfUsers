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
            self.nameLabel.text = user?.name
            self.emailLabel.text = user?.email
            self.isActiveLabel.text = user?.isActive ?? false ? "Active" : "Not Active"
            self.accessoryType = user?.isActive ?? false ? .disclosureIndicator : .none
            if let constraint = self.isActiveLabelTrailingConstraint {
                constraint.constant = user?.isActive ?? false ? 0 : -20
                self.contentView.updateConstraintsIfNeeded()
            }
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = .left
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let isActiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var isActiveLabelTrailingConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
