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
        let cellHeight: CGFloat = 140
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
        return 2
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
    @IBOutlet weak var detailedUserTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailedUserNotesArray)
        // Do any additional setup after loading the view.
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