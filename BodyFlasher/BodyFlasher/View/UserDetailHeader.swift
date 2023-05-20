//
//  UserDetailHeader.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-20.
//

import UIKit

class UserDetailHeader: UIView {
    
    let userIconView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "user-icon")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 20.0)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let professionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 13.0)
        label.backgroundColor = UIColor.clear
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
//        // user icon set
//        let imageURLStr = "https://picsum.photos/200/300.jpg"
//        if let imageURL = URL(string: imageURLStr) {
//            let session = URLSession.shared
//            let task = session.dataTask(with: imageURL) { (data, response, error) in
//                if let error = error {
//                    // Handle the error
//                    print("Error: \(error.localizedDescription)")
//                } else if let data = data, let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.userIconView.image = image
//                    }
//                }
//            }
//        }
        
        addSubview(userIconView)
        addSubview(usernameLabel)
        addSubview(professionLabel)
        
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            userIconView.topAnchor.constraint(equalTo: super.topAnchor),
            userIconView.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            userIconView.heightAnchor.constraint(equalToConstant: 40),
            userIconView.widthAnchor.constraint(equalToConstant: 40),
            
            usernameLabel.topAnchor.constraint(equalTo: super.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: userIconView.trailingAnchor, constant: 15),
            usernameLabel.trailingAnchor.constraint(equalTo: super.trailingAnchor),
            
            professionLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2),
            professionLabel.leadingAnchor.constraint(equalTo: userIconView.trailingAnchor, constant: 15),
            professionLabel.trailingAnchor.constraint(equalTo: super.trailingAnchor),
        ])
    }
}
