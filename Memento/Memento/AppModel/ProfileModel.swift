//
//  ProfileModel.swift
//  Memento
//
//  Created by Nevzat Acar on 16.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

class ProfileModel {
    
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
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    print(object.objectId as Any)
                }
            }
        }
    }
}
