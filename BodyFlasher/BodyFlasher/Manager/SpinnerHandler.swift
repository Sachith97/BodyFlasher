//
//  SpinnerHandler.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-27.
//

import Foundation
import UIKit

class SpinnerHandler {
    
    func handle(source: UIView, spinner: Spinner, status: Bool) {
        switch status {
        case true:
            // start animating
            source.bringSubviewToFront(spinner)
            spinner.animating(status: true)
        case false:
            // stop animating
            spinner.animating(status: false)
        }
    }
}
