//
//  NoteViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit


class NoteViewController: UIViewController {
    
    let noteModel = NoteModel()

    @IBOutlet weak var noteArea: UITextView!
    @IBOutlet weak var hashtagLabel: UITextField!
    @IBOutlet weak var visibilitySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 && hashtagLabel.isEditing{
            self.view.frame.origin.y -= noteArea.visibleSize.height/2
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if (noteArea.text != nil && hashtagLabel.text != nil) {
        noteModel.saveNote(noteText: noteArea.text!, hashtag: hashtagLabel.text!, visibility: visibilitySwitch.isOn)
        //should be in domain saveNote after save is guaranteed(protocol)
        noteArea.text = ""
        hashtagLabel.text = ""
        visibilitySwitch.setOn(true, animated: true)
        
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        print("out")
        noteModel.logOut()
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "logoutFromApp", sender: self)
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
