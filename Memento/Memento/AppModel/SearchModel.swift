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
    func startSearch()
    func goToDeterminedScreen()
    func wrongUsernameReaction()
}

class SearchModel {
    
    var otherUserNotesArray : [Note] = []
    var delegate : SearchModelDelegate?
    var profilePhoto = UIImage(named: "logo")
    var firstCheck = false
    var secondCheck = false
    var thirdCheck = false
    
    func loadNotesForOtherUser(username: String) {
        self.delegate?.startSearch()
        print(1)
        let noteQuery = PFQuery(className:"Note")
        noteQuery.whereKey("username", matchesText: username)
        noteQuery.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
                print("retrieve error")
                self.delegate?.wrongUsernameReaction()
                print(2)
            } else if let objects = objects {
                // The find succeeded.
                print(3)
                print("Successfully retrieved \(objects.count)")
                // Do something with the found objects
                for object in objects {
                    if (object["noteText"] != nil &&
                        object["hashtag"] != nil &&
                        object["visibility"] != nil &&
                        object["username"] != nil) {
                        if object["visibility"]! as! Bool {
                        self.otherUserNotesArray.append(Note(noteText: object["noteText"]! as! String, hashtag: object["hashtag"]! as! String, visibility: true, username: object["username"]! as! String))
                        }
                    }
                }
                self.firstCheck = true
                print(4)
                self.otherUserNotesArray.reverse()
                
            }
            print(self.firstCheck)
            print(self.secondCheck)
            print(self.thirdCheck)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                if (self.firstCheck && (self.secondCheck || self.thirdCheck)) {
                    print(5)
                    self.delegate?.goToDeterminedScreen()
                    self.firstCheck = false
                    self.secondCheck = false
                    self.thirdCheck = false
                }            })
            
        }
    }
    
    func loadProfilePhoto(username: String){
        let photoQuery = PFQuery(className:"ProfilePhoto")
        photoQuery.whereKey("username", matchesText: username)
        photoQuery.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
                print("retrieve error")
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                print(6)
                // Do something with the found objects
                if objects.count>0 {
                    print(7)
                    let userImageFile = objects[objects.count-1]["photo"]! as! PFFile
                    userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                            self.profilePhoto = UIImage(named: "logo")!
                            self.secondCheck = true
                            print(8)

                        } else if let imageData = imageData {
                            let image = UIImage(data:imageData)
                            self.profilePhoto = image
                            print(self.firstCheck)
                            self.secondCheck = true
                            
                            print(9)
                            
                        }
                   

                    }
                    
                }
                else {
                    self.profilePhoto = UIImage(named: "logo")!
                    self.thirdCheck = true
                    print(10)
                }
//                if (self.firstCheck && (self.secondCheck || self.thirdCheck)) {
//                    print(11)
//                    self.firstCheck=false
//                    self.secondCheck = false
//                    self.thirdCheck = false
//                    self.delegate?.goToDeterminedScreen()
//
//                }
                
                
                
            }
        }
        
        
    }
}
