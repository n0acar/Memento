//
//  NoteModel.swift
//  Memento
//
//  Created by Nevzat Acar on 16.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

protocol NoteModelDelegate {
    func changeMainPhoto(image: UIImage)
    func noteIsSaved()
}
class NoteModel {
    
    var delegate: NoteModelDelegate?
    let user = PFUser.current()!
    
    func saveNote(noteText: String, hashtag: String, visibility: Bool) {
        let note = PFObject(className:"Note")
        note["noteText"] = noteText
        note["hashtag"] = hashtag
        note["visibility"] = visibility
        note["username"] = user.username!
        note.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("The object saved")
                self.delegate?.noteIsSaved()
            }
            else {
                print("The object not saved")
            }
        }
    }
    func loadUserProfilePhoto(){
        if user["profilePhoto"] != nil {
        let userImageFile = user["profilePhoto"] as! PFFile
        userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let imageData = imageData {
                            let image = UIImage(data:imageData)
                            if image != nil {
                                self.delegate?.changeMainPhoto(image: image!)
                            }
                        }
                    }
                    
                }
    }

    
    func logOut() {
        PFUser.logOut()
    }
}
