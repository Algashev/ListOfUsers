//
//  UserDetailTagCell.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 21/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UserDetailTagCell: UITableViewCell {
    var user: User? {
        didSet {
            self.tagBodyLabel.text = user?.tags.map { "#\($0)" }.joined(separator: " ")
            self.tagBodyLabel.sizeToFit()
            self.tagScrollView.contentSize = self.tagBodyLabel.frame.size
        }
    }
    
    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "tags"
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        return label
    }()
    
    private let tagBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.textAlignment = .left
        return label
    }()
    
    private let tagScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(tagTitleLabel)
        self.contentView.addSubview(tagScrollView)
        self.tagScrollView.addSubview(tagBodyLabel)
        
        self.tagTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6).isActive = true
        self.tagTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.tagTitleLabel.widthAnchor.constraint(equalToConstant: 91).isActive = true
        
        self.tagScrollView.topAnchor.constraint(equalTo: self.tagTitleLabel.bottomAnchor, constant: 6).isActive = true
        self.tagScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.tagScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.tagScrollView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.tagScrollView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
