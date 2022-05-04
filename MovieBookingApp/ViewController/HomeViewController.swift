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
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    let movieModel: MovieModel = MovieModelImpl.shared
    let userModel: UserModel = UserModelImpl.shared
    
    private var comingSoonMovies: [Movie] = [] {
        didSet {
            collectionViewComingSoon.reloadData()
        }
    }
    
    private var nowShowingMovies: [Movie] = [] {
        didSet {
            collectionViewNowShowing.reloadData()
        }
    }
    
    var user: User? {
        didSet {
            lblUserName.text = "Hi \(user?.name ?? "")!"
            imgProfile.sd_setImage(with: URL(string: "\(baseURL)/\(user?.profileImage ?? "")"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        fetchProfile()
        registerCollectionViews()
        setUpDataSourceAndDelegate()
    }
    
    func fetchMovies(){
        movieModel.getComingMovies(take: 10){ result in
            switch result {
            case .success(let movies):
                self.comingSoonMovies = movies
            case .failure(let error):
                debugPrint("Error \(error)")
            }
        }
        movieModel.getShowingMovies(take: 10){
            result in
            switch result {
            case .success(let movies):
                self.nowShowingMovies = movies
            case .failure(let error):
                debugPrint("Error \(error)")
            }
        }
    }
    
    func fetchProfile(){
        userModel.getCurrentUser{ result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                debugPrint("Error \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        if collectionView == collectionViewComingSoon {
            return comingSoonMovies.count
        } else if collectionView == collectionViewNowShowing {
            return nowShowingMovies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: NowShowingCollectionViewCell.identifier, indexPath: indexPath) as NowShowingCollectionViewCell
        if collectionView == collectionViewNowShowing {
            cell.movie = nowShowingMovies[indexPath.row]
        } else if collectionView == collectionViewComingSoon {
            cell.movie = comingSoonMovies[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.bounds.width/2.8), height: CGFloat(280))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewNowShowing{
            navigateMovieDetailViewController(movie: nowShowingMovies[indexPath.row])
        } else if collectionView == collectionViewComingSoon  {
            navigateMovieDetailViewController(movie: comingSoonMovies[indexPath.row])
        }
        
    }
}
