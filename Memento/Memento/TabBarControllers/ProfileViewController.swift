//
//  ProfileViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit
import Parse


extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let finalYCoordinate = targetContentOffset.pointee.y
        let cellHeight: CGFloat = 120
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

extension ProfileViewController : ProfileModelDelegate {
    func noteListLoaded() {
        profileTableView.reloadData()
    }
    func changeMainPhoto(image: UIImage) {
        profileImageView.image = image
    }
    
    
}
class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let profileModel = ProfileModel()
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var profileSearchBar: UISearchBar!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileModel.delegate = self
        profileTableView.tableFooterView = UIView()
        self.hideKeyboardOnTap()
        profileModel.loadUserProfilePhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        profileModel.loadNotesForCurrentUser()
        profileModel.loadNotesForCurrentUser()
    }
    
    public func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc public func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //////////////
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.contentMode = .scaleAspectFit
            print(pickedImage)
            self.profileImageView.image = pickedImage
            profileModel.changeSavePhoto(image: pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /////////////
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
