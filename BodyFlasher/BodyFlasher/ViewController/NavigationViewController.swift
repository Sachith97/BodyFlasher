//
//  NavigationViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-07.
//

import UIKit

class NavigationViewController: UIViewController {

    let labelName: UILabel = {
        let label = UILabel()
        label.text = "BODY FLASHER"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"Noteworthy-Bold", size: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "dark-red")
        view.addSubview(labelName)
        setupConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.goToPlanRequestScreen()
        }
    }

    func setupConstraints() {
        labelName.widthAnchor.constraint(equalToConstant: 300).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func goToPlanRequestScreen() {
        let nextVC = PlanRequestViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func goToHomeScreen() {
        let nextVC = HomeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
