//
//  SearchModel.swift
//  Memento
//
//  Created by Nevzat Acar on 16.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation
import Parse

protocol SearchModelDelegate {
    func goToDeterminedScreen()
}

class SearchModel {
    
    var otherUserNotesArray : [Note] = []
    var delegate : SearchModelDelegate?
    
    func loadNotesForOtherUser(username: String) {
        let noteQuery = PFQuery(className:"Note")
        noteQuery.whereKey("username", matchesText: username)
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
                    if (object["noteText"] != nil &&
                        object["hashtag"] != nil &&
                        object["visibility"] != nil &&
                        object["username"] != nil) {
                        if object["visibility"]! as! Bool {
                            print("rrrr")
                        self.otherUserNotesArray.append(Note(noteText: object["noteText"]! as! String, hashtag: object["hashtag"]! as! String, visibility: true, username: object["username"]! as! String))
                        }
                        else {
                            print("wkssse")
                        }
                    }
                }
                self.delegate?.goToDeterminedScreen()
            }
        }
    }
}
