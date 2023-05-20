//
//  HomeViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import UIKit

//protocol HomeViewControllerDelegate: AnyObject {
//    func didTapMenuButton()
//}

class HomeViewController: UIViewController {
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    
//    weak var delegate: HomeViewControllerDelegate?
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "home-background")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.4
        imageView.applyBlurEffect()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userDetailHeader : UserDetailHeader = {
        let userDetailHeader = UserDetailHeader()
        userDetailHeader.backgroundColor = UIColor.clear
        userDetailHeader.translatesAutoresizingMaskIntoConstraints = false
        return userDetailHeader
    }()
    
    let startIcon : NSTextAttachment = {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "start-icon")
        attachment.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        return attachment
    }()
    
    let workoutPlanContainer : UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        uiView.layer.cornerRadius = 10
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    let workoutPlanContainerBackgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "workoutplans-background")
        imageView.alpha = 0.4
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let workoutPlanHeaderLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"DINCondensed-Bold", size: 27.0)
        label.text = "WORKOUT PLANS"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let workoutPlanDescLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
        label.text = "Check your workouts"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let workoutPlanProcessIconLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 17.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customPlanContainer : UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        uiView.layer.cornerRadius = 10
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    let customPlanContainerBackgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "customplans-background")
        imageView.alpha = 0.4
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let customPlanHeaderLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name:"DINCondensed-Bold", size: 27.0)
        label.text = "CUSTOM PLANS"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customPlanDescLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
        label.text = "Start instant workout or create custom workout plans"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customPlanProcessIconLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 17.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide default back icon
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // set background image
        self.view.insertSubview(backgroundView, at: 0)
//        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 16/255, green: 17/255, blue: 18/255, alpha: 1.0))
        
        // slider menu
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
//                                                           style: .done,
//                                                           target: self,
//                                                           action: #selector(didTapMenuButton))
        
        // set user's details
        self.userDetailHeader.usernameLabel.text = (self.authDetail.user?.firstName ?? "Anonymous") + " " + (self.authDetail.user?.lastName ?? "User")
        self.userDetailHeader.professionLabel.text = (self.authDetail.user?.profession ?? "Profession")
        
        // initiate start icon
        let startIconStr = NSMutableAttributedString(string: "")
        let startIconNSStr = NSAttributedString(attachment: startIcon)
        startIconStr.append(startIconNSStr)
        
        // set process icon
        workoutPlanProcessIconLabel.attributedText = startIconStr
        customPlanProcessIconLabel.attributedText = startIconStr
        
        workoutPlanContainer.addSubview(workoutPlanContainerBackgroundView)
        workoutPlanContainer.addSubview(workoutPlanHeaderLabel)
        workoutPlanContainer.addSubview(workoutPlanDescLabel)
        workoutPlanContainer.addSubview(workoutPlanProcessIconLabel)
        
        let workoutPlanTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToWorkoutPlanList))
        workoutPlanContainer.addGestureRecognizer(workoutPlanTapGesture)
        
        customPlanContainer.addSubview(customPlanContainerBackgroundView)
        customPlanContainer.addSubview(customPlanHeaderLabel)
        customPlanContainer.addSubview(customPlanDescLabel)
        customPlanContainer.addSubview(customPlanProcessIconLabel)
        
        let customPlanTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToCustomPlanCreate))
        customPlanContainer.addGestureRecognizer(customPlanTapGesture)
        
        view.addSubview(userDetailHeader)
        view.addSubview(workoutPlanContainer)
        view.addSubview(customPlanContainer)
        
        setupConstraints()
    }
    
//    @objc func didTapMenuButton() {
//        delegate?.didTapMenuButton()
//    }
    
    @objc func goToWorkoutPlanList() {
        
    }
    
    @objc func goToCustomPlanCreate(_ gesture: UITapGestureRecognizer) {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            userDetailHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userDetailHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userDetailHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            workoutPlanContainer.topAnchor.constraint(equalTo: userDetailHeader.bottomAnchor, constant: 80),
            workoutPlanContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            workoutPlanContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            workoutPlanContainer.heightAnchor.constraint(equalToConstant: workoutPlanHeaderLabel.intrinsicContentSize.height + workoutPlanDescLabel.intrinsicContentSize.height + 150),
            
            workoutPlanContainerBackgroundView.topAnchor.constraint(equalTo: workoutPlanContainer.topAnchor),
            workoutPlanContainerBackgroundView.leadingAnchor.constraint(equalTo: workoutPlanContainer.leadingAnchor),
            workoutPlanContainerBackgroundView.trailingAnchor.constraint(equalTo: workoutPlanContainer.trailingAnchor),
            workoutPlanContainerBackgroundView.bottomAnchor.constraint(equalTo: workoutPlanContainer.bottomAnchor),
            
            workoutPlanHeaderLabel.topAnchor.constraint(equalTo: workoutPlanContainer.topAnchor, constant: 30),
            workoutPlanHeaderLabel.leadingAnchor.constraint(equalTo: workoutPlanContainer.leadingAnchor, constant: 20),
            workoutPlanHeaderLabel.trailingAnchor.constraint(equalTo: workoutPlanProcessIconLabel.leadingAnchor, constant: -20),
            
            workoutPlanDescLabel.topAnchor.constraint(equalTo: workoutPlanHeaderLabel.bottomAnchor, constant: 10),
            workoutPlanDescLabel.leadingAnchor.constraint(equalTo: workoutPlanContainer.leadingAnchor, constant: 20),
            workoutPlanDescLabel.trailingAnchor.constraint(equalTo: workoutPlanProcessIconLabel.leadingAnchor, constant: -20),
            
            workoutPlanProcessIconLabel.topAnchor.constraint(equalTo: workoutPlanContainer.topAnchor, constant: 35),
            workoutPlanProcessIconLabel.trailingAnchor.constraint(equalTo: workoutPlanContainer.trailingAnchor, constant: -20),
            workoutPlanProcessIconLabel.widthAnchor.constraint(equalToConstant: 55),
            
            customPlanContainer.topAnchor.constraint(equalTo: workoutPlanContainer.bottomAnchor, constant: 30),
            customPlanContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            customPlanContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            customPlanContainer.heightAnchor.constraint(equalToConstant: customPlanHeaderLabel.intrinsicContentSize.height + customPlanDescLabel.intrinsicContentSize.height + 150),
            
            customPlanContainerBackgroundView.topAnchor.constraint(equalTo: customPlanContainer.topAnchor),
            customPlanContainerBackgroundView.leadingAnchor.constraint(equalTo: customPlanContainer.leadingAnchor),
            customPlanContainerBackgroundView.trailingAnchor.constraint(equalTo: customPlanContainer.trailingAnchor),
            customPlanContainerBackgroundView.bottomAnchor.constraint(equalTo: customPlanContainer.bottomAnchor),
            
            customPlanHeaderLabel.topAnchor.constraint(equalTo: customPlanContainer.topAnchor, constant: 30),
            customPlanHeaderLabel.leadingAnchor.constraint(equalTo: customPlanContainer.leadingAnchor, constant: 20),
            customPlanHeaderLabel.trailingAnchor.constraint(equalTo: customPlanProcessIconLabel.leadingAnchor, constant: -20),
            
            customPlanDescLabel.topAnchor.constraint(equalTo: customPlanHeaderLabel.bottomAnchor, constant: 10),
            customPlanDescLabel.leadingAnchor.constraint(equalTo: customPlanContainer.leadingAnchor, constant: 20),
            customPlanDescLabel.trailingAnchor.constraint(equalTo: customPlanProcessIconLabel.leadingAnchor, constant: -20),
            
            customPlanProcessIconLabel.topAnchor.constraint(equalTo: customPlanContainer.topAnchor, constant: 35),
            customPlanProcessIconLabel.trailingAnchor.constraint(equalTo: customPlanContainer.trailingAnchor, constant: -20),
            customPlanProcessIconLabel.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
