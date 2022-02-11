//
//  ViewController.swift
//  InstagramClone
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        Authentication()
    }
    
    func Authentication(){
        if Auth.auth().currentUser == nil{
            let LVC = LoginViewController()
            LVC.modalPresentationStyle = .fullScreen
            present(LVC, animated: true)
        }
    }


}

