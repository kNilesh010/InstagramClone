//
//  FollowersViewController.swift
//  FollowersViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit

class FollowersViewController: UIViewController {

    var data: [userFollowersFollowing]
    
    private var table: UITableView = {
    let table = UITableView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Followers"
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        table.register(FollowersCustomTableViewCell.self, forCellReuseIdentifier: FollowersCustomTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
    }
    
    init(data: [userFollowersFollowing]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    

}

extension FollowersViewController: UITableViewDelegate, UITableViewDataSource, FollowersCustomTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowersCustomTableViewCell.identifier, for: indexPath) as! FollowersCustomTableViewCell
        cell.ConfigCell(model: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didTapFollowUnfollowButton(model: userFollowersFollowing) {
        
        switch model.type{
        case .following:
            break
        case .notFollowing:
            break
        }
    }
}

