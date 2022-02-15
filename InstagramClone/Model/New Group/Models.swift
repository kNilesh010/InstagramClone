//
//  Models.swift
//  Models
//
//  Created by Nilesh Kumar on 15/02/22.
//

import Foundation
import UIKit

public struct userPost{
    let postID: String
    let postType: userPostType
    let postImageURL: URL
    let postCaption: String?
    let postLikesCount: [postLike]
    let postComments: [Comments]
    let postedDate: Date
    let taggedUsers: [String]?
}

enum userPostType{
    case photo, video
}

public struct postLike{
    let postID: String
    let userName: String
    let likesCount: Int
}

public struct Comments{
    let postID: String
    let comments: String
    let userName: String
    let commentsLikes: [commentLike]
    let commentedDate: Date
}

public struct commentLike{
    let postID: String
    let userName: String
    let likesCount: Int
}

///custom error message

enum storageErrors: Error{
    case unableToDownload
}

struct user{
    let username:String
    let name: (firstName: String, lastName: String)
    let bio: String
    let age: Int
    let email: String
    let profileImage: String
    let gender: Gender
    let counts: [UserCount]
    let joinedDate: Date
}


enum Gender{
    
   case Male, Female
}


struct UserCount{
    let followers: Int
    let follwing: Int
    let posts: Int
}
