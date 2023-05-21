//
//  WorkoutTableViewCell.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-21.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    let workoutImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let workoutNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let workoutTimeLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 13.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTagLabel: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 11.0)
        button.backgroundColor = UIColor(named: "dark-green")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let startIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "start-icon")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(workoutImage)
        contentView.addSubview(workoutNameLabel)
        contentView.addSubview(workoutTimeLabel)
        contentView.addSubview(goalTagLabel)
        contentView.addSubview(startIcon)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        contentView.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCOder) is not implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            workoutImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            workoutImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            workoutImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            workoutImage.heightAnchor.constraint(equalToConstant: 100),
            workoutImage.widthAnchor.constraint(equalToConstant: 100),
            
            workoutNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutImage.trailingAnchor, constant: 20),
            workoutNameLabel.trailingAnchor.constraint(equalTo: startIcon.leadingAnchor, constant: -20),
            
            workoutTimeLabel.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 5),
            workoutTimeLabel.leadingAnchor.constraint(equalTo: workoutImage.trailingAnchor, constant: 20),
            workoutTimeLabel.trailingAnchor.constraint(equalTo: startIcon.leadingAnchor, constant: -20),
            
            goalTagLabel.topAnchor.constraint(equalTo: workoutTimeLabel.bottomAnchor, constant: 20),
            goalTagLabel.leadingAnchor.constraint(equalTo: workoutImage.trailingAnchor, constant: 20),
            goalTagLabel.widthAnchor.constraint(equalToConstant: 100),
            goalTagLabel.heightAnchor.constraint(equalToConstant: 20),
            
            startIcon.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            startIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            startIcon.heightAnchor.constraint(equalToConstant: 40),
            startIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
