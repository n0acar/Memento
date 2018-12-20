//
//  SignUpViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 5.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit
import Parse

//extension SignUpViewController: NameModelDelegate {
//}

class SignUpViewController: UIViewController {

    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Save an object with some properties
        
    }
    @IBAction func FinishButton(_ sender: Any) {
        if !(UsernameText.text == nil || PasswordText.text == nil){
            self.signIn(username: UsernameText.text!, password: PasswordText.text!)
            print("if")
        }
        else {
            //must bedeclared
            print("else")
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
                self.performSegue(withIdentifier: "signUpToApp", sender: self)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
