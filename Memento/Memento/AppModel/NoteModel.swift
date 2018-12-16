//
//  NoteModel.swift
//  Memento
//
//  Created by Nevzat Acar on 16.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

class NoteModel {
    
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
            }
            else {
                print("The object not saved")
            }
        }
    }
    
    func logOut() {
        PFUser.logOut()
    }
}
