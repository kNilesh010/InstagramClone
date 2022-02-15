//
//  FollowersCustomTableViewCell.swift
//  FollowersCustomTableViewCell
//
//  Created by Nilesh Kumar on 16/02/22.
//

import UIKit

protocol FollowersCustomTableViewCellDelegate: AnyObject{
    func didTapFollowUnfollowButton(model: userFollowersFollowing)
}

class FollowersCustomTableViewCell: UITableViewCell {
    
    static let identifier = "FollowersCustomTableViewCell"
    
    public weak var delegate: FollowersCustomTableViewCellDelegate?
    
    private var model: userFollowersFollowing?
    
    private let followersProfileImage: UIImageView = {
        let followersProfileImage = UIImageView()
        followersProfileImage.contentMode = .scaleAspectFill
        followersProfileImage.layer.cornerRadius = 10.0
        followersProfileImage.layer.masksToBounds = true
        followersProfileImage.backgroundColor = .red
        return followersProfileImage
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.font = .boldSystemFont(ofSize: 16.0)
        nameLabel.textColor = .label
        nameLabel.text = "Nile"
        return nameLabel
    }()
    
    private let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.numberOfLines = 1
        usernameLabel.textColor = .secondaryLabel
        usernameLabel.text = "Nil"
        return usernameLabel
    }()
    
    private let followButton: UIButton = {
        let followButton = UIButton()
        followButton.layer.cornerRadius = 4.0
        followButton.layer.masksToBounds = true
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        followButton.setTitle("Follow", for: .normal)
        followButton.backgroundColor = .link
        return followButton
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(followersProfileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followersProfileImage.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        followersProfileImage.frame = CGRect(x: 5, y: 5, width: contentView.height - 10, height: contentView.height - 10)
        followersProfileImage.layer.cornerRadius = followersProfileImage.height / 2
        
        let buttonWidth = contentView.width > 500.0 ? 220.0 : contentView.width / 3
        
        followButton.frame = CGRect(x: contentView.width - 3 - buttonWidth, y: 3, width: buttonWidth, height: contentView.height - 6)
        
        nameLabel.frame = CGRect(x: followersProfileImage.right + 5, y: 5, width: contentView.width - 10 - followersProfileImage.width - followButton.width, height: contentView.height / 2)
        usernameLabel.frame = CGRect(x: followersProfileImage.right + 5, y: nameLabel.bottom - 15, width: contentView.width - 10 - followersProfileImage.width - followButton.width, height: contentView.height)
    }
    
    public func ConfigCell(model: userFollowersFollowing){
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.userName
        switch model.type{
        case .following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .systemGray
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.systemGray.cgColor
        case .notFollowing:
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
        }
    }
    
    @objc func didTapFollowButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
}

struct userFollowersFollowing{
    let name: String
    let userName: String
    let type: FollowState
}

enum FollowState{
    case following, notFollowing
}
