//
//  TabBarVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/7/24.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = .systemPink
        self.tabBar.backgroundColor = .systemGray5
        addVC()
    }
    
    
    private func addVC() {
        let firstVC = MainVC()
        firstVC.view.backgroundColor = .systemGreen
        let firstNavVC = UINavigationController(rootViewController: firstVC)
        firstNavVC.tabBarItem = UITabBarItem(title: "First", image: nil, selectedImage: nil)
        firstNavVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        
        let secondVC = BookListVC()
        secondVC.view.backgroundColor = .systemPurple
        let secondNavVC = UINavigationController(rootViewController: secondVC)
        secondNavVC.tabBarItem = UITabBarItem(title: "Second", image: nil, selectedImage: nil)
        secondNavVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        
        self.viewControllers = [firstNavVC, secondNavVC]
    }

    
    // createNavigationController 함수 추가
    private func createNavigationController(for rootViewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        return navigationController
    }
}
