//
//  AuthManager.swift
//  AuthManager
//
//  Created by Nilesh Kumar on 11/02/22.
//

import Foundation
import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    
    func registerNewUser(email: String, username: String, password: String, completion: @escaping ((Bool)->Void)){
        DataManager.shared.canCreateNewUsers(email: email, userName: username) { success in
            if success{
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil, error == nil else{
                        completion(true)
                        return
                        //insert the record in database
                        DataManager.shared.insertUsersinDatabase(email: email, userName: username) { success in
                            if success{
                                //data inserted successfully
                                completion(true)
                            }else {
                                completion(false)
                            }
                        }
                    }
                    completion(false)
                }
            }else {
                completion(false)
            }
        }
    }
    
    
    
    func loginUsers(email: String?, userName: String?, password: String, completion: @escaping ((Bool)->Void)){
        if let email = email {
            //signin from email
            Auth.auth().signIn(withEmail: email, password: password) { authresult, error in
                guard authresult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = userName{
            //signin with username
        }
    }
    
    ///Logout user from application
    
    public func signOutUser(completion: @escaping ((Bool) ->Void)){
        
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch {
            completion(false)
            return
        }
    }
    
}
