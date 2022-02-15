//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {
    
    private var data = [[settingsModel]]()
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        configModel()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    private func configModel(){
        
        data.append([
            settingsModel(title: "Edit Profile", handler: {[weak self] in
                self?.didTapEditProfile()
            }),
            settingsModel(title: "Invite Friends", handler: {[weak self] in
                self?.didTapInviteFriends()
            }),
            settingsModel(title: "Save Tweets", handler: {[weak self] in
                self?.didTapSaveTweets()
            })
        ])
        
        data.append([
            settingsModel(title: "Terms & Conditions", handler: {[weak self] in
                self?.clickUrls(type: .terms)
            }),
            settingsModel(title: "Privacy Policy", handler: {[weak self] in
                self?.clickUrls(type: .policies)
            }),
            settingsModel(title: "Help/Contact Us", handler: {[weak self] in
                self?.clickUrls(type: .help)
            })
        ])

        data.append([
            settingsModel(title: "Logout", handler: {[weak self] in
                self?.tapLogOutButton()
            })
        ])
    }
    
    private func didTapEditProfile(){
        let editProfileController = UINavigationController(rootViewController: EditProfileViewController())
        editProfileController.modalPresentationStyle = .fullScreen
        editProfileController.title = "Edit profile"
        present(editProfileController, animated: true)
    }
    
    private func didTapInviteFriends(){
        
    }
    
    private func didTapSaveTweets(){
        
    }
    
    
    enum urlCase{
        
        case terms, policies, help
    }
    
    func clickUrls(type: urlCase){
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .policies:
            urlString = "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0"
        case .help:
            urlString = "https://help.instagram.com/581066165581870"
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated: true)
    }
    
    private func tapLogOutButton(){
        
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        logoutAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { alert in
            AuthManager.shared.signOutUser { loggedout in
                DispatchQueue.main.async {
                    if loggedout{
                        //logged out successfull
                        let lvc = LoginViewController()
                        lvc.modalPresentationStyle = .fullScreen
                        self.present(lvc, animated: true){
                            self.navigationController?.popToRootViewController(animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        //error
                        print("fatal error")
                    }
                }
                
            }
        }))
        logoutAlert.popoverPresentationController?.sourceView = table
        logoutAlert.popoverPresentationController?.sourceRect = table.bounds
        present(logoutAlert, animated: true)
            
        }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.section][indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}

struct settingsModel {
    
    let title: String
    let handler: (() ->Void)
}
