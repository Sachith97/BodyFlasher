//
//  LoginViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-17.
//

import UIKit

class LoginViewController: UIViewController {
    
    var networkManager = NetworkManager.shared
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "login-background")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 25.0)
        label.text = "WELCOME"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Username"
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let middleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 13.0)
        label.text = "OR"
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("CREATE NEW ACCOUNT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgotPasswordTapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPassword))
    let forgotPasswordLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 13.0)
        label.text = "FORGOT PASSWORD"
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // hide default back icon
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        // set background image
        self.view.insertSubview(backgroundView, at: 0)
        self.view.backgroundColor = .black
        
        // add tap gesture for forgot password label
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordTapGesture)
        
        self.view.addSubview(headerLabel)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginButton)
        self.view.addSubview(middleLabel)
        self.view.addSubview(signUpButton)
        self.view.addSubview(forgotPasswordLabel)
        
        setupConstraints()
    }
    
    @objc func login() {
        if (usernameField.text!.isEmpty) {
            createAlert(title: nil, message: "Please enter username")
        } else if (passwordField.text!.isEmpty) {
            createAlert(title: nil, message: "Please enter password")
        } else {
            // initialize waiting indicator
            // let waitingIndicator = self.waitingIndicator()
            // get API response
            let response = networkManager.login(username: usernameField.text!, password: passwordField.text!)
            // kill waiting indicator on response
            // self.killWaitingIndicator(waitingIndicator: waitingIndicator)
            // response validation
            if (response.isOk!) {
                // proceed
                let planRequestVC = PlanRequestViewController()
                self.navigationController?.pushViewController(planRequestVC, animated: true)
            } else {
                createAlert(title: "Error", message: response.responseMessage!)
            }
        }
    }
    
    func createAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func signUp() {
        let planRequestVC = PlanRequestViewController()
        self.navigationController?.pushViewController(planRequestVC, animated: true)
    }
    
    @objc func forgotPassword() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            usernameField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 80),
            usernameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            middleLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            middleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            middleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 15),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    // validate text field length
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString

        return newString.length <= maxLength
    }
}

extension LoginViewController {
    
    func waitingIndicator() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func killWaitingIndicator(waitingIndicator: UIAlertController) {
        DispatchQueue.main.async {
            waitingIndicator.dismiss(animated: true, completion: nil)
        }
    }
}
