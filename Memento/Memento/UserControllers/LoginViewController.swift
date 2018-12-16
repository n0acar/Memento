//
//  LoginViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 5.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit
import Parse

//extension LoginViewController: NameModelDelegate {
//}

class LoginViewController: UIViewController {

    	
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userModel.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userModel.isLoggedIn() {
            print("performm")
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "loginToApp", sender: self)
            }
        }
    }
   
   
    @IBAction func loginButton(_ sender: Any) {
        if !(UserNameText.text == nil || PasswordText.text == nil){
            userModel.login(username: UserNameText.text!, password: PasswordText.text!)
            print("if")
        }
        else {
            //must bedeclared
            print("else")
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
