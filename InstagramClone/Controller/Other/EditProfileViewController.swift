//
//  EditProfileViewController.swift
//  EditProfileViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    var mySettingsModel = [[editProfilelabels]]()
    
    private let myTable: UITableView = {
        let myTable = UITableView()
        return myTable
    }()
    
    override func viewDidLoad() {
        
        configureModel()
        
        super.viewDidLoad()
        title = "Edit Profile"
        
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapCancel))
        view.addSubview(myTable)
        myTable.register(FormsTableViewCell.self, forCellReuseIdentifier: FormsTableViewCell.identifier)
        myTable.tableHeaderView = myHeaderView()
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    private func configureModel(){
        
        let section1 = ["Name", "Username", "Bio"]
        var section1Model = [editProfilelabels]()
        for name in section1{
            let myModel = editProfilelabels(name: name, placeHolder: "Enter \(name)", value: "")
            section1Model.append(myModel)
        }
        mySettingsModel.append(section1Model)
        
        let section2 = ["Email", "Phone", "Gender"]
        var section2Model = [editProfilelabels]()
        for name in section2{
            let myModel = editProfilelabels(name: name, placeHolder: "Enter \(name)", value: "")
            section2Model.append(myModel)
        }
        mySettingsModel.append(section2Model)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {return nil}
        return "Personal Information Settings"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTable.frame = view.bounds
    }
    
   @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSave(){
        dismiss(animated: true, completion: nil)
     }
    
    public func myHeaderView() -> UIView{
        let myHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4))
        let size = myHeader.height / 1.5
        let profileImage = UIButton(frame: CGRect(x: (view.width - size) / 2, y: (myHeader.height - size) / 2, width: size, height: size))
        profileImage.tintColor = .label
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = size / 2.0
        profileImage.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        profileImage.layer.borderColor = UIColor.secondaryLabel.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.addTarget(self, action: #selector(didClickedPic), for: .touchUpInside)
        myHeader.addSubview(profileImage)
        return myHeader
    }
    
   @objc private func didClickedPic(){
        
    }
    
    private func changeProfilePic(){
        let actionSheet = UIAlertController(title: "Update Profile", message: "Please update your picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { cameraAlert in
            print("tapped camera")
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { photoAlert in
            print("tapped photo")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true, completion: nil)
    }
   
}


extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySettingsModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySettingsModel[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = mySettingsModel[indexPath.section][indexPath.row]
        guard let cell = myTable.dequeueReusableCell(withIdentifier: FormsTableViewCell.identifier, for: indexPath) as? FormsTableViewCell else {
            return UITableViewCell()
            
        }
        cell.configure(model: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


struct editProfilelabels{
    var name: String
    var placeHolder: String
    var value: String?
}

extension EditProfileViewController: FormsTableViewCellDelegate{
    func didUpdateFieldValue(_ cell: FormsTableViewCell, updatedField: editProfilelabels?) {
        print(updatedField?.value ?? "nil")
    }
    
}
