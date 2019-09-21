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
            case .blue: eyeColorView.backgroundColor = UIColor.blue
            case .brown: eyeColorView.backgroundColor = UIColor.brown
            case .green: eyeColorView.backgroundColor = UIColor.green
            }
        }
    }
    
    private let eyeColorView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func configureEyeColorViewWith(circleRadius radius: CGFloat = 5) {
        self.eyeColorView.heightAnchor.constraint(equalToConstant: radius * 2).isActive = true
        self.eyeColorView.widthAnchor.constraint(equalToConstant: radius * 2).isActive = true
        self.eyeColorView.layer.cornerRadius = radius
        self.eyeColorView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        guard let textLabel = self.textLabel else { return }
        self.eyeColorView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 6).isActive = true
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
