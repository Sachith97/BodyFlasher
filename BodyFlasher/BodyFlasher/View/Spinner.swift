//
//  Spinner.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-22.
//

import UIKit

class Spinner: UIView {

    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set default view status
        self.isHidden = true
        self.backgroundColor = .black
        self.alpha = 0.6
        
        self.addSubview(spinner)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoder is not implemented")
    }
    
    func animating(status: Bool) {
        switch status {
        case true:
            self.spinner.startAnimating()
            self.isHidden = false
        case false:
            self.spinner.stopAnimating()
            self.isHidden = true
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
