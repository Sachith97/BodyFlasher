//
//  UserProfileDataView.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-22.
//

import UIKit

class UserProfileDataView: UIView {

    let headerLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 18.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 14.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(headerLabel)
        addSubview(descLabel)
        
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            super.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.topAnchor.constraint(equalTo: super.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: super.trailingAnchor),
            
            descLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            descLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: super.trailingAnchor)
        ])
    }
}
