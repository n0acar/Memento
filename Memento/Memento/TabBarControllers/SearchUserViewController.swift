//
//  SearchUserViewController.swift
//  Memento
//
//  Created by Nevzat Acar on 12.12.2018.
//  Copyright © 2018 Brothers. All rights reserved.
//

import UIKit

extension SearchUserViewController: SearchModelDelegate {
    func startSearch() {
        self.present(searchAlert, animated: true)
    }
    func goToDeterminedScreen() {
        self.performSegue(withIdentifier: "searchByUsername", sender: self)
        searchAlert.dismiss(animated: true, completion: nil)
    }
    func wrongUsernameReaction() {
        searchAlert.dismiss(animated: true, completion: nil)
        self.present(cannotSearchAlert, animated: true)
    }
    
    
}

class SearchUserViewController: UIViewController {


    @IBOutlet weak var locationSlider: UISlider!
    
    @IBOutlet weak var usernameSearchBar: UISearchBar!
    
    let searchAlert = UIAlertController(title: "Searching", message: "Searching", preferredStyle: .alert)
    let cannotSearchAlert = UIAlertController(title: "Wrong Username", message: "No user is registered with this username", preferredStyle: .alert)
    let searchModel = SearchModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchModel.delegate = self
        print(searchModel.otherUserNotesArray)
        self.hideKeyboardOnTap()
        cannotSearchAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(searchModel.otherUserNotesArray)

    }
    
    
    @IBAction func searchByUsernameButton(_ sender: Any) {
        if usernameSearchBar.text != nil {
            searchModel.loadNotesForOtherUser(username: usernameSearchBar.text!)
            searchModel.loadProfilePhoto(username: usernameSearchBar.text!)

        }
    }
    
    @IBAction func searchByLocationButton(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailedUserViewController
        vc.detailedUserNotesArray = searchModel.otherUserNotesArray
        vc.detailedProfilePhoto = searchModel.profilePhoto
        searchModel.otherUserNotesArray = []
        searchModel.profilePhoto = UIImage(named: "logo")
    }
    
    public func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc public func hideKeyboard() {
        view.endEditing(true)
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
