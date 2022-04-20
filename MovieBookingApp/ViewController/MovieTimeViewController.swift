//
//  MovieTimeViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 16/02/2022.
//

import Foundation
import UIKit
import SideMenu

class MovieTimeViewController: UIViewController{
    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    @IBOutlet weak var collectionViewGoldenCity: UICollectionView!
    @IBOutlet weak var collectionViewWestPoint: UICollectionView!
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightGoldenCity: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightWestPoint: NSLayoutConstraint!
    
    @IBOutlet weak var viewTime: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setUpDataSourceAndDelegate()
        setUpHeightForCollectionView()
        setCornerViewTime()
    }
    
    private func setCornerViewTime(){
        viewTime.clipsToBounds = true
        viewTime.layer.cornerRadius = 24
        viewTime.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    fileprivate func registerCells(){
        collectionViewDays.registerForCell(identifier: DaysCollectionViewCell.identifier)
        collectionViewAvailableIn.registerForCell(identifier: TimeCollectionViewCell.identifier)
        collectionViewGoldenCity.registerForCell(identifier: TimeCollectionViewCell.identifier)
        collectionViewWestPoint.registerForCell(identifier: TimeCollectionViewCell.identifier)
    }
    
    fileprivate func setUpDataSourceAndDelegate(){
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewGoldenCity.dataSource = self
        collectionViewGoldenCity.delegate = self
        
        collectionViewWestPoint.dataSource = self
        collectionViewWestPoint.delegate = self
    }
    
    fileprivate func setUpHeightForCollectionView(){
        collectionViewHeightAvailableIn.constant = 56
        collectionViewHeightGoldenCity.constant = 56 * 2
        collectionViewHeightWestPoint.constant = 56 * 2
        //View Reload
        self.view.layoutIfNeeded()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension MovieTimeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewDays {
            return 10;
        }else if collectionView == collectionViewAvailableIn{
            return 3
        }
        return 6;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewDays {
            let cell = collectionView.dequeueCell(identifier: DaysCollectionViewCell.identifier, indexPath: indexPath)
            return cell;
        }else if collectionView == collectionViewAvailableIn || collectionView == collectionViewGoldenCity || collectionView == collectionViewWestPoint{
            let cell = collectionView.dequeueCell(identifier: TimeCollectionViewCell.identifier, indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
}


extension MovieTimeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewDays {
            return CGSize(width: 60, height: 80)
        } else {
            return CGSize(width: collectionView.bounds.width / 3, height: 48)
        }
        
    }
}
