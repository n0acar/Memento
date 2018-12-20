//
//  OtherUserTableViewCell.swift
//  Memento
//
//  Created by Nevzat Acar on 20.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit


class OtherUserTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var noteTextArea: UITextView!
    
    
    @IBOutlet weak var hashtagTextField: UITextField!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
