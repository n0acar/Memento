//
//  LoginViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 5.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    	
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func LoginButton(_ sender: Any) {
    }
    @IBAction func SignUpButton(_ sender: Any) {
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