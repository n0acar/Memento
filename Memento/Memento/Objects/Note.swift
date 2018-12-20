//
//  Note.swift
//  Memento
//
//  Created by Nevzat Acar on 17.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import Foundation

class Note {
    
    let noteText : String
    let hashtag : String
    let visibility : Bool
    let username : String
    
    init(noteText: String, hashtag : String, visibility : Bool, username : String){
        self.noteText = noteText
        self.hashtag = hashtag
        self.visibility = visibility
        self.username = username
    }
}
