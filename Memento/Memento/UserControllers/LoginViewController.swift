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
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= logoTopConstraint.constant
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
            self.login(username: UserNameText.text!, password: PasswordText.text!)
            print("if")
        }
        else {
            //must bedeclared
            print("else")
        }
    }
    
    func login(username: String, password: String){
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                // Do stuff after successful login.
                print("Logged")
                DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "loginToApp", sender: self)
                }
            } else {
                // The login failed. Check error to see why.
                print(error as Any)
                print("Not logged")
            }
        }
    }
    
    public func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc public func hideKeyboard() {
        view.endEditing(true)
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
