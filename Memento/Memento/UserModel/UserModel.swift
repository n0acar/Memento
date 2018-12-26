//
//  UserModel.swift
//  Memento
//
//  Created by Nevzat Acar on 7.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

protocol UserModelDelegate {
    func startLogin()
    func goToDeterminedScreen()
    func wrongPasswordReaction()
}
class UserModel {
    
    var delegate: UserModelDelegate?

    func login(username: String, password: String){
        self.delegate?.startLogin()
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                // Do stuff after successful login.
                self.delegate?.goToDeterminedScreen()
            } else {
                // The login failed. Check error to see why.
                self.delegate?.wrongPasswordReaction()
                print(error as Any)
            }
        }
    }
    
    
    func isLoggedIn () -> Bool {
        let currentUser = PFUser.current()
        if currentUser != nil {
            print(currentUser!)
            print("loggeddd")
            return true
        } else {
            print("not logged in")
            return false
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
