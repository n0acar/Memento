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
        let cellHeight: CGFloat = 128
        var mode = finalYCoordinate.truncatingRemainder(dividingBy: cellHeight)
        if mode > cellHeight/2 {
            mode = -(cellHeight-mode)
        }
        targetContentOffset.pointee.y = finalYCoordinate - mode
    }
    
    
}

//extension ProfileViewController: UICollectionViewDataSource {
//
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return citiesDataSource.citiesArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topTenCitiesCollection", for: indexPath) as! TopTenCityCollectionViewCell
//
//        let city = citiesDataSource.citiesArray[indexPath.row]
//
//        cityCell.cityImageView.image = UIImage(named: city.imageName)
//        cityCell.rankingLabel.text = "\(city.ranking)"
//        cityCell.cityNameLabel.text = "\(city.cityName)"
//        cityCell.countryNameLabel.text = "\(city.countryName)"
//
//        return cityCell
//
//    }
//
//
//
//
//}

class ProfileViewController: UIViewController {
    
    let profileModel = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         profileModel.loadNotesForCurrentUser()
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
