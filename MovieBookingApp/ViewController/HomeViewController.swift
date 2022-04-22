//
//  HomeViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 20/02/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    @IBOutlet weak var collectionViewComingSoon: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        navigationItem.lef
//        navigationItem.backButtonTitle = ""
//        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        registerCollectionViews()
        setUpDataSourceAndDelegate()
    }
    
    private func registerCollectionViews(){
        collectionViewNowShowing.registerForCell(identifier: NowShowingCollectionViewCell.identifier)
        collectionViewComingSoon.registerForCell(identifier: NowShowingCollectionViewCell.identifier)
    }
    
    private func setUpDataSourceAndDelegate(){
        collectionViewNowShowing.dataSource = self
        collectionViewNowShowing.delegate = self
        
        collectionViewComingSoon.dataSource = self
        collectionViewComingSoon.delegate = self
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: NowShowingCollectionViewCell.identifier, indexPath: indexPath)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.bounds.width/2.8), height: CGFloat(280))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateMovieDetailViewController()
    }
}
