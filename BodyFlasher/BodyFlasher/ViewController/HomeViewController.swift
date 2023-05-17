//
//  HomeViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        // hide default back icon
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
