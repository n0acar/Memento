//
//  UserModel.swift
//  Memento
//
//  Created by Nevzat Acar on 7.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

//protocol UserModelDelegate {
//}
class UserModel {
    func login(username: String, password: String){
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                // Do stuff after successful login.
                print("Logged")
            } else {
                // The login failed. Check error to see why.
                print(error as Any)
                print("Not logged")
            }
        }
    }
    
    func signIn(username: String, password: String) {
        let user = PFUser()
        user["username"] = username
        user["password"] = password
        
        user.signUpInBackground { (success, error) in
            if let error = error {
                let errorString = error._userInfo!["error"]
                print(errorString as Any)
            }
            else{
                print("Sign In is Successful")
            }
        }
        
    }
}
