//
//  UserDetailAboutCell.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 21/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UserDetailAboutCell: UITableViewCell {
    var user: User? {
        didSet {
            self.aboutBodyLabel.text = user?.about
        }
    }
    
    private let aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "about"
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        return label
    }()
    
    private let aboutBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(aboutTitleLabel)
        self.contentView.addSubview(aboutBodyLabel)
        
        self.aboutTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6).isActive = true
        self.aboutTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.aboutTitleLabel.widthAnchor.constraint(equalToConstant: 91).isActive = true
        
        self.aboutBodyLabel.topAnchor.constraint(equalTo: self.aboutTitleLabel.bottomAnchor, constant: 6).isActive = true
        self.aboutBodyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.aboutBodyLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.aboutBodyLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
