//
//  ProfileTableViewCell.swift
//  Memento
//
//  Created by Nevzat Acar on 19.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
 
    @IBOutlet weak var noteTextArea: UITextView!
    @IBOutlet weak var hashtagTextField: UITextField!
    @IBOutlet weak var visibilityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
