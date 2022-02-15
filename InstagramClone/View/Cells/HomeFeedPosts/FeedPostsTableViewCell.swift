//
//  FeedPostsTableViewCell.swift
//  FeedPostsTableViewCell
//
//  Created by Nilesh Kumar on 13/02/22.
//

import UIKit

final class FeedPostsTableViewCell: UITableViewCell {

    static let identifier = "FeedPostsTableViewCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
