//
//  DataManager.swift
//  DataManager
//
//  Created by Nilesh Kumar on 11/02/22.
//

import Foundation
import FirebaseDatabase

public class DataManager{
    
    static let shared = DataManager()
    
    let database = Database.database().reference()
    
    //to check if username and email is available
   public func canCreateNewUsers(email: String, userName: String, completion: @escaping ((Bool)->Void)){
        completion(true)
    }
    //insert users in database
    public func insertUsersinDatabase(email: String, userName: String, completion: @escaping ((Bool)->Void)){
        database.child(email.replacePeriod()).setValue(["Username": userName]) {error, DataSnapshot in
            if error == nil {
                completion(true)
                return
            }else {
                completion(false)
                return
            }
        }
    }
   
    
}
