//
//  MenuContainerViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-20.
//

import UIKit

class MenuContainerViewController: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addChildVCs()
    }
    
    private func addChildVCs() {
        // menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // home
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

//extension MenuContainerViewController: HomeViewControllerDelegate {
//    func didTapMenuButton() {
//        print("called in menu")
//        // animate the menu
//        switch menuState {
//        case .closed:
//            // open menu
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//                
//                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
//                
//            } completion: { [weak self] done in
//                if (done) {
//                    self?.menuState = .opened
//                }
//            }
//            
//        case .opened:
//            // close menu
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//                
//                self.navVC?.view.frame.origin.x = 0
//                
//            } completion: { [weak self] done in
//                if (done) {
//                    self?.menuState = .closed
//                }
//            }
//        }
//    }
//}
