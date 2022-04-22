//
//  MovieDetailViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 21/02/2022.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController{
    @IBOutlet weak var stackViewDetail: UIStackView!
    @IBOutlet weak var collectionViewMovieType: UICollectionView!
    @IBOutlet weak var collectionViewCast: UICollectionView!
    @IBOutlet weak var viewDetailTopCorner: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCornerOfViewDetail()
        setUpCollectionViewMovieType()
        setUpCollectionViewCast()
    }
    
    private func roundCornerOfViewDetail(){
        viewDetailTopCorner.clipsToBounds = true
        viewDetailTopCorner.layer.cornerRadius = 30
        viewDetailTopCorner.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setUpCollectionViewMovieType(){
        collectionViewMovieType.registerForCell(identifier: MovieTypeCollectionViewCell.identifier)
        collectionViewMovieType.dataSource = self
        collectionViewMovieType.delegate = self
    }
    
    private func setUpCollectionViewCast(){
        collectionViewCast.registerForCell(identifier: CastCollectionViewCell.identifier)
        collectionViewCast.dataSource = self
        collectionViewCast.delegate = self
    }
    
    @IBAction func onClickGetYourTicket(_ sender: Any) {
        navigateToMovieTimeViewController()
    }

}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewMovieType {
            return 2
        } else if collectionView == collectionViewCast{
            return 3
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewMovieType {
            let cell = collectionView.dequeueCell(identifier: MovieTypeCollectionViewCell.identifier, indexPath: indexPath)
            return cell
        } else if collectionView == collectionViewCast{
            let cell = collectionView.dequeueCell(identifier: CastCollectionViewCell.identifier, indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewMovieType {
            return CGSize(width: 100, height: CGFloat(40))
        } else if collectionView == collectionViewCast{
            return CGSize(width: CGFloat(80), height: CGFloat(80))
        }
        return CGSize(width: 100, height: CGFloat(40))
    }
}
