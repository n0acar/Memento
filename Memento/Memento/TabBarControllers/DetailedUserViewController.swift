//
//  DetailedUserViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit

extension DetailedUserViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let finalYCoordinate = targetContentOffset.pointee.y
        let cellHeight: CGFloat = 120
        var mode = finalYCoordinate.truncatingRemainder(dividingBy: cellHeight)
        if mode > cellHeight/2 {
            mode = -(cellHeight-mode)
        }
        targetContentOffset.pointee.y = finalYCoordinate - mode
        print("scroll")
    }
    
}

extension DetailedUserViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailedUserNotesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailedUserCell = tableView.dequeueReusableCell(withIdentifier: "detailedUserTableCell", for: indexPath) as! OtherUserTableViewCell
        
        let note = detailedUserNotesArray[indexPath.row]
        
        detailedUserCell.noteTextArea.text = note.noteText
        detailedUserCell.hashtagTextField.text = note.hashtag
        
        
        return detailedUserCell
    }
    
    
}
class DetailedUserViewController: UIViewController {

    var detailedUserNotesArray: [Note] = []
    var detailedProfilePhoto: UIImage?
    @IBOutlet weak var detailedUserTableView: UITableView!
    
    @IBOutlet weak var otherUserProfileImageView: UIImageView!
    @IBOutlet weak var otherUserSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailedUserNotesArray)
        detailedUserTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchOtherUserPressed(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let detailedProfilePhoto = detailedProfilePhoto {
            otherUserProfileImageView.image = detailedProfilePhoto
            print("\(detailedProfilePhoto) nev")
        }
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
