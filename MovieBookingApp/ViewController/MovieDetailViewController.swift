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
    @IBOutlet weak var starRate: RatingControl!
    
    @IBOutlet weak var moivePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    
    let movieModel: MovieModel = MovieModelImpl.shared
    
    var movieId: Int?
    
    var movie: Movie? {
        didSet {
            if let m = movie {
                lblMovieName.text = m.originalTitle ?? ""
                if let duration = m.runtime {
                    lblDuration.text = "\(duration / 60)hr \(duration % 60)min"
                } else {
                    lblDuration.text = "- hr -min"
                }
                lblRating.text = "IMDb \(m.rating ?? 0)"
                starRate.startCount = 5
                starRate.rating = Int(m.rating ?? 0) / 2
                moivePoster.sd_setImage(with: URL(string: "\(baseImageUrl)/\(m.posterPath ?? "")"))
                genres = m.genres ?? []
                lblSummary.text = m.overview ?? ""
                casts = m.casts ?? []
            }
        }
    }
    
    private var genres: [String]? = [] {
        didSet {
            collectionViewMovieType.reloadData()
        }
    }
    
    private var casts: [Cast] = [] {
        didSet {
            collectionViewCast.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCornerOfViewDetail()
        setUpCollectionViewMovieType()
        setUpCollectionViewCast()
     
        if let id = movieId {
            fetchMovieById(id)
        }
    }
    
    private func fetchMovieById(_ id: Int){
        movieModel.getMovieById(id: id){[weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
            case .failure(let error):
                debugPrint(error)
            }
        }
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
        if let m = movie {
            MovieTicketVo.movie = m
            navigateToMovieTimeViewController()
        }
    }
    
    deinit {
        MovieTicketVo.movie = nil
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewMovieType {
            return genres?.count ?? 0
        } else if collectionView == collectionViewCast{
            return casts.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewMovieType {
            let cell = collectionView.dequeueCell(identifier: MovieTypeCollectionViewCell.identifier, indexPath: indexPath) as MovieTypeCollectionViewCell
            cell.lblGenreName.text = genres?[indexPath.row] ?? ""
            return cell
        } else if collectionView == collectionViewCast{
            let cell = collectionView.dequeueCell(identifier: CastCollectionViewCell.identifier, indexPath: indexPath) as CastCollectionViewCell
            cell.image = casts[indexPath.row].profilePath
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
