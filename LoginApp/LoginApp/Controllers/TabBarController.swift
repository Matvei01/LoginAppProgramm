//
//  TabBarController.swift
//  LoginApp
//
//  Created by Matvei Khlestov on 04.04.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        let welcomeViewController = UINavigationController(
            rootViewController: WelcomeViewController()
        )
        
        let userInfoViewController = UINavigationController(
            rootViewController: UserInfoViewController()
        )
        
        viewControllers = [
            generateVC(
                viewController: welcomeViewController,
                image: UIImage(systemName: "house.fill")
            ),
            generateVC(
                viewController: userInfoViewController,
                image: UIImage(systemName: "person.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        
        return viewController
    }
}
