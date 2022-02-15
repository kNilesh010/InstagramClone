//
//  StorageManager.swift
//  StorageManager
//
//  Created by Nilesh Kumar on 11/02/22.
//

import Foundation
import FirebaseStorage

public class storageManager{
    
   static let storagemanager = storageManager()
    
    public let storageRef = Storage.storage().reference()
    
    public func userPosts(posts: userPost, completion: @escaping ((Result<URL, Error>) -> Void)){
        
    }
    
    public func downloadPosts(downloadUrl: String, completion: @escaping ((Result<URL, Error>) -> Void)){
        storageRef.child(downloadUrl).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(storageErrors.unableToDownload))
                return
            }
            completion(.success(url))

        }
    }
    
}

