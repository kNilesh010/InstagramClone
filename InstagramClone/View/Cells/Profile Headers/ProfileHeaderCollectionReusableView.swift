//
//  ProfileHeaderCollectionReusableView.swift
//  ProfileHeaderCollectionReusableView
//
//  Created by Nilesh Kumar on 14/02/22.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject{
    
    func postsButtontapped(_ header: ProfileHeaderCollectionReusableView)
    func followersButtontapped(_ header: ProfileHeaderCollectionReusableView)
    func followingButtontapped(_ header: ProfileHeaderCollectionReusableView)
    func editProfileButtontapped(_ header: ProfileHeaderCollectionReusableView)
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    public var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImage: UIImageView = {
        let profilePhotoImage = UIImageView()
        profilePhotoImage.contentMode = .scaleAspectFill
        profilePhotoImage.backgroundColor = .red
        return profilePhotoImage
    }()
    
    private let PostButton: UIButton = {
        let PostButton = UIButton()
        PostButton.setTitle("Posts", for: .normal)
        PostButton.backgroundColor = .label
        return PostButton
    }()
    
    private let FollowersButton: UIButton = {
        let FollowersButton = UIButton()
        FollowersButton.setTitle("Followers", for: .normal)
        FollowersButton.backgroundColor = .label
        return FollowersButton
    }()
    
    private let FollowingButton: UIButton = {
        let FollowingButton = UIButton()
        FollowingButton.setTitle("Following", for: .normal)
        FollowingButton.backgroundColor = .label
        return FollowingButton
    }()
    
    private let EditProfileButton: UIButton = {
        let EditProfileButton = UIButton()
        EditProfileButton.backgroundColor = .label
        EditProfileButton.setTitle("Edit Profile", for: .normal)
        return EditProfileButton
    }()
    
    private let userNamelabel: UILabel = {
        let userNamelabel = UILabel()
        userNamelabel.text = "User Name"
        return userNamelabel
    }()
    
    private let BioLabel: UILabel = {
        let userNamelabel = UILabel()
        userNamelabel.text = "This is a simple Bio"
        return userNamelabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubViews()
        addButtonFunctions()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews(){
        addSubview(profilePhotoImage)
        addSubview(PostButton)
        addSubview(FollowersButton)
        addSubview(FollowingButton)
        addSubview(EditProfileButton)
        addSubview(userNamelabel)
        addSubview(BioLabel)
        
    }
    
    private func addButtonFunctions(){
        PostButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        FollowersButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        FollowingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        EditProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let photoSize = width / 4
        
        profilePhotoImage.frame = CGRect(x: 5, y: 5, width: photoSize, height: photoSize).integral
        profilePhotoImage.layer.cornerRadius = photoSize / 2
        profilePhotoImage.layer.masksToBounds = true
        
        let buttonHeight = photoSize / 2
        
        PostButton.frame = CGRect(x: profilePhotoImage.right, y: 5, width: (width - 10 - profilePhotoImage.width) / 3, height: buttonHeight).integral
        
        FollowersButton.frame = CGRect(x: PostButton.right, y: 5, width: (width - 10 - profilePhotoImage.width) / 3, height: buttonHeight).integral
        
        FollowingButton.frame = CGRect(x: FollowersButton.right, y: 5, width: (width - 10 - profilePhotoImage.width) / 3, height: buttonHeight).integral
        
        EditProfileButton.frame = CGRect(x: profilePhotoImage.right, y: 5 + buttonHeight, width: ((photoSize*3) - 10), height: buttonHeight).integral
        
        userNamelabel.frame = CGRect(x: 5, y: 5 + profilePhotoImage.bottom, width: ((photoSize*3) - 10), height: buttonHeight).integral
        let bioSize = BioLabel.sizeThatFits(self.frame.size)
        BioLabel.frame = CGRect(x: 5, y: userNamelabel.bottom, width: ((photoSize*3) - 10), height: bioSize.height).integral
    }
    
    ///Add Button Actions
    
    @objc func didTapPostButton(){
        delegate?.postsButtontapped(self)
    }
    
    @objc func didTapFollowerButton(){
        delegate?.followersButtontapped(self)
    }
    
    @objc func didTapFollowingButton(){
        delegate?.followingButtontapped(self)
    }
    
    @objc func didTapEditProfileButton(){
        delegate?.editProfileButtontapped(self)
    }
}
