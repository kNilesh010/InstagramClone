//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var userPostModel = [userPost]()
    private var data: [userFollowersFollowing]?
    private var mycollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configure()
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.width - 2) / 3, height: (view.width - 2) / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mycollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        guard let mycollectionView = mycollectionView else {
//            return
//        }
//
//        mycollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
//        mycollectionView.register(ProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
//        mycollectionView.register(HeaderTabbedCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTabbedCollectionReusableView.identifier)
//        mycollectionView.delegate = self
//        mycollectionView.dataSource = self
//        view.addSubview(mycollectionView)
        addSubViews()
        
        
    }
    
    private func addSubViews(){
        guard let mycollectionView = mycollectionView else {
            return
        }
        view.addSubview(mycollectionView)
        mycollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        mycollectionView.register(ProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
        mycollectionView.register(HeaderTabbedCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTabbedCollectionReusableView.identifier)
        mycollectionView.delegate = self
        mycollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mycollectionView?.frame = view.bounds
    }
    
    private func configure(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapButton))
    }

    @objc func didTapButton(){
        let settingController = SettingsViewController()
        settingController.title = "Settings"
        navigationController?.pushViewController(settingController, animated: true)
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
       // return userPostModel.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let model = userPostModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .systemBlue
       // cell.configure(with: model)
        cell.configure(with: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
         let model = userPostModel[indexPath.row]
        let vc = PostsViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        present(vc, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            let TabbedHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderTabbedCollectionReusableView.identifier, for: indexPath) as! HeaderTabbedCollectionReusableView
            TabbedHeaderCell.delegate = self
            return TabbedHeaderCell
        }
        let profileHeadereaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileHeaderCollectionReusableView
        
        profileHeadereaderCell.delegate = self
        
        return profileHeadereaderCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height / 3)
        }else {
            return CGSize(width: collectionView.width, height: 50.0)
        }
    }
}


extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate{
    
    func postsButtontapped(_ header: ProfileHeaderCollectionReusableView) {
        mycollectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func followersButtontapped(_ header: ProfileHeaderCollectionReusableView) {
        var mockData = [userFollowersFollowing]()
        for x in 0..<10 {
            mockData.append(userFollowersFollowing(name: "Nil", userName: "Nilu", type: x % 2 == 0 ? .following : .notFollowing))
        }
        let vc = FollowersViewController(data: mockData)
        vc.title = "Followers"
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func followingButtontapped(_ header: ProfileHeaderCollectionReusableView) {
        var mockData = [userFollowersFollowing]()
        for x in 0..<10 {
            mockData.append(userFollowersFollowing(name: "Nil", userName: "Nilu", type: x % 2 == 0 ? .following : .notFollowing))
        }
        let vc = FollowersViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func editProfileButtontapped(_ header: ProfileHeaderCollectionReusableView) {
        let vc = UINavigationController(rootViewController: EditProfileViewController())
        vc.title = "Edit Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension ProfileViewController: HeaderTabbedCollectionReusableViewDelegate {
    
    func didTappedGridButton() {
        
    }
    
    func didTappedTagButton() {
        
    }
    
    
}
