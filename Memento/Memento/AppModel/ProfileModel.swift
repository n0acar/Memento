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
    func changeMainPhoto(image: UIImage)
}

class ProfileModel {
    
    var delegate: ProfileModelDelegate?
    let user = PFUser.current()!
    var notesArray : [Note] = []
    
    init () {
        loadNotesForCurrentUser()
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
                self.notesArray.reverse()
                self.delegate?.noteListLoaded()
            }
        }
    }
    
    func searchForTag(notesArray: [Note], hashtag: String) -> [Note] {
        var taggedNotesArray: [Note] = []
        for note in notesArray {
            if (note.hashtag == hashtag) {
                taggedNotesArray.append(note)
            }
        }
        return taggedNotesArray
    }
    
    func changeSavePhoto(image: UIImage) {
        let imageData = image.pngData()
        if let imageData = imageData {
            let profilePhoto = PFObject(className:"ProfilePhoto")
            let imageFile = PFFile(name:"\(user["username"]!).png", data:imageData)
            user["profilePhoto"] = imageFile
            profilePhoto["photo"] = imageFile
            profilePhoto["username"] = user["username"]!
            user.saveInBackground()
            profilePhoto.saveInBackground()
        }
        
    }
    
}
