//
//  PhotoCollectionViewCell.swift
//  PhotoCollectionViewCell
//
//  Created by Nilesh Kumar on 14/02/22.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-Tap to open the post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = contentView.bounds
    }
    
    func configure(with model: userPost){
        let url = model.postImageURL
        myImageView.sd_setImage(with: url, completed: nil)
    }
    
    func configure(with image: String){
        myImageView.image = UIImage(named: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}
