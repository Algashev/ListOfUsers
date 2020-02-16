//
//  UserDetailEyeColorCell.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 21/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class UserDetailEyeColorCell: UITableViewCell {
    var user: User? {
        didSet {
            guard let eyeColor = user?.eyeColor else { return }
            switch eyeColor {
            case .blue: eyeColorView.backgroundColor = .blue
            case .brown: eyeColorView.backgroundColor = .brown
            case .green: eyeColorView.backgroundColor = .green
            }
        }
    }
    
    private let eyeColorView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func configureEyeColorViewWith(circleRadius radius: CGFloat = 5) {
        let eyeColorSize = CGSize(width: radius * 2, height: radius * 2)
        self.eyeColorView.addSizeConstraints(eyeColorSize)
        self.eyeColorView.layer.cornerRadius = radius
        self.eyeColorView.addConstraint(.centerY, equalTo: self.contentView)
        guard let textLabel = self.textLabel else { return }
        self.eyeColorView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 6).activate()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(eyeColorView)
        
        self.textLabel?.text = "eye color"
        self.configureEyeColorViewWith(circleRadius: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
