//
//  NoteViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit


class NoteViewController: UIViewController {
    
    let noteModel = NoteModel()

    @IBOutlet weak var noteArea: UITextView!
    @IBOutlet weak var hashtagLabel: UITextField!
    @IBOutlet weak var visibilitySwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if (noteArea.text != nil && hashtagLabel.text != nil) {
        noteModel.saveNote(noteText: noteArea.text!, hashtag: hashtagLabel.text!, visibility: visibilitySwitch.isOn)
        }
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        
//        
////        let cell = sender as! TopTenCityCollectionViewCell
////        let indexPath = topTenCitiesCollectionView.indexPath(for: cell)
////        let city = citiesDataSource.citiesArray[indexPath!.row]
//        print("log out in view")
//        noteModel.logOut()
//        //let loginScreen = segue.destination as! LoginViewController
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
