//
//  TabsViewController.swift
//  TabsViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setUpTapBarControllers()

    }
    
    func setUpTapBarControllers(){

        let HVC = HomeViewController()
        let SVC = SearchViewController()
        let CVC = CameraViewController()
        let NVC = NotificationsViewController()
        let PVC = ProfileViewController()
    
        setViewControllers([HVC, SVC, CVC, NVC, PVC], animated: false)
        
    }

}
