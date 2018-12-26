//
//  NoteViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit

extension NoteViewController : NoteModelDelegate {
    func changeMainPhoto(image: UIImage) {
        mainPhotoImageView.image = image
    }
    func noteIsSaved() {
        self.present(savedNoteAlert, animated: true)
    }
    
}
class NoteViewController: UIViewController {
    
    let noteModel = NoteModel()

    @IBOutlet weak var noteArea: UITextView!
    @IBOutlet weak var hashtagLabel: UITextField!
    @IBOutlet weak var visibilitySwitch: UISwitch!
    @IBOutlet weak var mainPhotoImageView: UIImageView!
    let savedNoteAlert = UIAlertController(title: "Saved", message: "Note is saved", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        noteModel.delegate = self
        savedNoteAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        self.hideKeyboardOnTap()
    }
    override func viewWillAppear(_ animated: Bool) {
        noteModel.loadUserProfilePhoto()

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
            //self.navigationController?.popToRootViewController(animated: true)
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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
