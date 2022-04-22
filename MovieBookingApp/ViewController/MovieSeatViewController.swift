//
//  MovieSeatViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 19/02/2022.
//

import Foundation
import UIKit

class MovieSeatViewController: UIViewController{
    @IBOutlet weak var collectionViewSeat: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setDataSourceAndDelegate()
    }
    
    func setDataSourceAndDelegate(){
        collectionViewSeat.dataSource = self
        collectionViewSeat.delegate = self
    }
    
    func registerCollectionView(){
        collectionViewSeat.register(UINib(nibName: String(describing: MovieSeatCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:  MovieSeatCollectionViewCell.self))
    }
    
    @IBAction func onClickBuy(_ sender: Any) {
        navigateToSnackViewController()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieSeatViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyMovieSeats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieSeatCollectionViewCell.self), for: indexPath) as? MovieSeatCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bindData(movieSeatVo: dummyMovieSeats[indexPath.row])
        return cell
    }
    
}


extension MovieSeatViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(collectionView.bounds.width / 10)
        let height = CGFloat(40)
        return CGSize(width: width, height: height)
    }
}
