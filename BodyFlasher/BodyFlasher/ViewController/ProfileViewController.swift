//
//  ProfileViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "home-background")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.4
        imageView.applyBlurEffect()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userIconView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "user-icon")
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let fullNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Regular", size: 13.0)
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userInfoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let professionView: UserProfileDataView = {
        let view = UserProfileDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weightView: UserProfileDataView = {
        let view = UserProfileDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let heightView: UserProfileDataView = {
        let view = UserProfileDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bmiView: UserProfileDataView = {
        let view = UserProfileDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let signoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("SIGN OUT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 13.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide default nav bar
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.title = "Profile"
        
        // set background image
        self.view.insertSubview(backgroundView, at: 0)
        
        self.setUserInfo()
        
        userInfoContainer.addSubview(userIconView)
        userInfoContainer.addSubview(fullNameLabel)
        userInfoContainer.addSubview(emailLabel)
        
        self.view.addSubview(userInfoContainer)
        self.view.addSubview(professionView)
        self.view.addSubview(weightView)
        self.view.addSubview(heightView)
        self.view.addSubview(bmiView)
        self.view.addSubview(signoutButton)
        
        setupConstraints()
    }
    
    func setUserInfo() {
        fullNameLabel.text = (self.authDetail.user?.firstName ?? "Anonymous") + " " + (self.authDetail.user?.lastName ?? "User")
        emailLabel.text = (self.authDetail.user?.email ?? "anonymous@email.com")
        
        professionView.headerLabel.text = "Profession"
        professionView.descLabel.text = (self.authDetail.user?.profession ?? "profession")
        
        var weightString = "0"
        if let weight = self.authDetail.user?.weight {
            weightString = String(weight) + " KG"
        }
        weightView.headerLabel.text = "Weight"
        weightView.descLabel.text = weightString
        
        var heightString = "0"
        if let height = self.authDetail.user?.height {
            heightString = String(height) + " CM"
        }
        heightView.headerLabel.text = "Height"
        heightView.descLabel.text = heightString
        
        var bmiString = "0"
        if let bmi = self.authDetail.user?.bmiValue {
            bmiString = String(format: "%.2f", bmi)
        }
        bmiView.headerLabel.text = "BMI"
        bmiView.descLabel.text = bmiString
    }
    
    @objc func signout() {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        
        // create a "Confirm" action
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { (_) in
            // process sign out action
            let loginVC = LoginViewController()
            // finding the appropriate UIWindowScene
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                    return
            }
            // set the sign-in view controller as the root view controller
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = loginVC
            sceneDelegate.window = window
            // make the new window key and visible
            window.makeKeyAndVisible()
        }
        alert.addAction(confirmAction)
        
        // create a "Cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // present the alert
        present(alert, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            userInfoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userInfoContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userInfoContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userInfoContainer.heightAnchor.constraint(equalToConstant: 200),
            
            userIconView.topAnchor.constraint(equalTo: userInfoContainer.topAnchor),
            userIconView.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor),
            userIconView.heightAnchor.constraint(equalToConstant: 120),
            userIconView.widthAnchor.constraint(equalToConstant: 120),
            
            fullNameLabel.topAnchor.constraint(equalTo: userIconView.bottomAnchor, constant: 20),
            fullNameLabel.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 3),
            emailLabel.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor),
            
            professionView.topAnchor.constraint(equalTo: userInfoContainer.bottomAnchor, constant: 30),
            professionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            professionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            weightView.topAnchor.constraint(equalTo: professionView.bottomAnchor, constant: 20),
            weightView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weightView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            heightView.topAnchor.constraint(equalTo: weightView.bottomAnchor, constant: 20),
            heightView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            heightView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            bmiView.topAnchor.constraint(equalTo: heightView.bottomAnchor, constant: 20),
            bmiView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bmiView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            signoutButton.topAnchor.constraint(equalTo: bmiView.bottomAnchor, constant: 40),
            signoutButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            signoutButton.widthAnchor.constraint(equalToConstant: 100),
            signoutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
