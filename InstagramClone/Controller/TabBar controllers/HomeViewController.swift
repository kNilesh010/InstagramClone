//
//  ViewController.swift
//  InstagramClone
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    private var table: UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        Authentication()
        view.addSubview(table)
        table.register(FeedPostsTableViewCell.self, forCellReuseIdentifier: FeedPostsTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func Authentication(){
        if Auth.auth().currentUser == nil{
            let LVC = LoginViewController()
            LVC.modalPresentationStyle = .fullScreen
            present(LVC, animated: true)
        }
    }


}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: FeedPostsTableViewCell.identifier, for: indexPath) as? FeedPostsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
}
