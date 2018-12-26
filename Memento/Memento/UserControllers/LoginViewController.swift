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

extension LoginViewController : UserModelDelegate {
    func startLogin() {
        self.present(loginAlert, animated: true)
    }
    func goToDeterminedScreen() {
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "loginToApp", sender: self)
        }
        loginAlert.dismiss(animated: true, completion: nil)
    }
    func wrongPasswordReaction() {
        loginAlert.dismiss(animated: true, completion: nil)
        self.present(cannotLoginAlert, animated: true)
    }
    
}
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    let userModel = UserModel()
    let loginAlert = UIAlertController(title: "Login", message: "Please, wait until login", preferredStyle: .alert)
    let cannotLoginAlert = UIAlertController(title: "Wrong", message: "Wrong Username or Password", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        userModel.delegate = self
        cannotLoginAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
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
            userModel.login(username: UserNameText.text!, password: PasswordText.text!)
        }
        else {
            //must bedeclared
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
