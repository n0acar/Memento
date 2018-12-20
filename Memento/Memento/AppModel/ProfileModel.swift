//
//  ProfileModel.swift
//  Memento
//
//  Created by Nevzat Acar on 16.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

protocol ProfileModelDelegate {
    func noteListLoaded()
}

class ProfileModel {
    
    var delegate: ProfileModelDelegate?
    
    var notesArray : [Note] = []
    
    init () {
        loadNotesForCurrentUser()
    }
    
    let user = PFUser.current()!
    
    func loadNotesForCurrentUser() {
        let noteQuery = PFQuery(className:"Note")
        noteQuery.whereKey("username", matchesText: user.username!)
        noteQuery.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
                print("retrieve error")
            } else if let objects = objects {
                // The find succeeded.
                self.notesArray = []
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    if (object["noteText"] != nil &&
                        object["hashtag"] != nil &&
                    object["visibility"] != nil &&
                    object["username"] != nil) {
                        self.notesArray.append(Note(noteText: object["noteText"]! as! String, hashtag: object["hashtag"]! as! String, visibility: object["visibility"]! as! Bool, username: object["username"]! as! String))
                    }
                }
                self.delegate?.noteListLoaded()
            }
        }
    }
    
}
