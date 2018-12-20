//
//  ProfileViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit
import Parse

//extension ProfileViewController: ProfileModelDelegate {
//    func noteListLoaded(noteList: [Note]) {
//        self.notesArray = noteList
//        DispatchQueue.main.async {
//            self.profileCollectionView.reloadData()
//        }
//
//    }
//}
extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let finalYCoordinate = targetContentOffset.pointee.y
        let cellHeight: CGFloat = 140
        var mode = finalYCoordinate.truncatingRemainder(dividingBy: cellHeight)
        if mode > cellHeight/2 {
            mode = -(cellHeight-mode)
        }
        targetContentOffset.pointee.y = finalYCoordinate - mode
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("control")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileModel.notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = tableView.dequeueReusableCell(withIdentifier: "profileTableCell", for: indexPath) as! ProfileTableViewCell
        
        let note = profileModel.notesArray[indexPath.row]
        
        if note.visibility {
                        profileCell.visibilityImageView.image = UIImage(named: "noteBlue")
                    } else {
                        profileCell.visibilityImageView.image = UIImage(named: "noteBlack")
                    }
        
                    profileCell.noteTextArea.text = note.noteText
                    profileCell.hashtagTextField.text = note.hashtag
                    print("control")
        return profileCell
    }
    
   
}


//extension ProfileViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print("control")
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("control")
//        return profileModel.notesArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("control")
//        let profileCell = tableView.dequeueReusableCell(withIdentifier: "profileTableCell", for: indexPath) as! ProfileTableViewCell
//        let note = profileModel.notesArray[indexPath.row]
//
//        if note.visibility {
//            profileCell.visibilityImageView.image = UIImage(named: "noteBlue")
//        } else {
//            profileCell.visibilityImageView.image = UIImage(named: "noteBlack")
//        }
//
//        profileCell.noteTextArea.text = note.noteText
//        profileCell.hashtagTextField.text = note.hashtag
//        print("control")
//        return profileCell
//    }
//}

class ProfileViewController: UIViewController {
    
    let profileModel = ProfileModel()
    

    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("control")
        // Do any additional setup after loading the view.
        //        profileModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        profileModel.loadNotesForCurrentUser()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
