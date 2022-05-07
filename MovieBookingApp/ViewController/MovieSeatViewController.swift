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
    @IBOutlet weak var heightofCollectionViewSeat: NSLayoutConstraint!
    @IBOutlet weak var lblSelectedCount: UILabel!
    @IBOutlet weak var lblSelectedSeat: UILabel!
    @IBOutlet weak var btnBuyTicket: UIButton!
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblCinema: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    let seatModel: SeatModel = SeatModelImpl.shared
    
    var seats: [Seat] = [] {
        didSet {
            collectionViewSeat.reloadData()
        }
    }
    
    var selectedSeats: [Seat] = [] {
        didSet {
            lblSelectedCount.text = "\(selectedSeats.count)"
            
            var seatMap: [String: [Seat]] = [String: [Seat]]()
            selectedSeats.forEach { seat in
                seatMap[seat.symbol!] = selectedSeats.filter{ $0.symbol == seat.symbol }
            }
            lblSelectedSeat.text = seatMap.map{ row, value in
                let numbers = value.map{ $0.seatName?.split(separator: "-").last?.description ?? "" }.joined(separator: ", ")
                return "\(row) Row/ \(numbers)"
            }.joined(separator: "\n")
            
            let totalCharges = selectedSeats.reduce(0) { previous, seat in
                return previous + (seat.price ?? 0)
            }
            btnBuyTicket.setTitle("Buy Ticket for $\(totalCharges)", for: .normal)
            collectionViewSeat.reloadData()
        }
    }
    
    var columnCount: Int = 0
    var rowCount: Int = 0 {
        didSet {
            heightofCollectionViewSeat.constant = CGFloat((UIScreen.main.bounds.width / CGFloat(columnCount)) * CGFloat(rowCount))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setDataSourceAndDelegate()
        fetchSeats()
        dataBind()
    }
    
    func setDataSourceAndDelegate(){
        collectionViewSeat.dataSource = self
        collectionViewSeat.delegate = self
    }
    
    func registerCollectionView(){
        collectionViewSeat.register(UINib(nibName: String(describing: MovieSeatCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:  MovieSeatCollectionViewCell.self))
    }
    
    func dataBind(){
        lblMovieName.text = MovieTicketVo.movie?.originalTitle ?? ""
        let movieTime =  MovieTicketVo.movieTime
        let time = movieTime?.date.toFormat(format: "EEEE, dd MMM")
        lblCinema.text = movieTime?.cinema.name ?? ""
        lblTime.text = "\(time ?? ""), \(movieTime?.timeSlot.startTime ?? "")"
    }
    
    func fetchSeats(){
        seatModel.getSeat(timeSlotId: 1, date: "2022-5-13"){[weak self] result in
            switch result {
            case .success(let seats):
                self?.seats = seats.reduce([Seat]()){ results, rowseat in
                    var l = results
                    l.append(contentsOf: rowseat)
                    return l
                }
                if !seats.isEmpty {
                    self?.columnCount = seats.first?.count ?? 0
                    self?.rowCount = seats.count
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    @IBAction func onClickBuy(_ sender: Any) {
        if selectedSeats.count != 0 {
            MovieTicketVo.movieSeat = MovieSeatVo(seat: selectedSeats)
            navigateToSnackViewController()
        }
    }
    
    deinit {
        MovieTicketVo.movieSeat = nil
    }
}

extension MovieSeatViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieSeatCollectionViewCell.self), for: indexPath) as? MovieSeatCollectionViewCell else {
            return UICollectionViewCell()
        }
        let isSelected = selectedSeats.contains { seat in seats[indexPath.row].seatName
            == seat.seatName }
        cell.bindData(seat: seats[indexPath.row], isSelected: isSelected)
        return cell
    }
    
}


extension MovieSeatViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(collectionView.bounds.width / CGFloat(columnCount))
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let select = seats[indexPath.row]
        if select.isMovieSeatAvailable() {
            let isSelected = selectedSeats.contains { seat in select.seatName
                == seat.seatName }
            if isSelected {
                //Remove
                selectedSeats.removeAll{ seat in seat.seatName == select.seatName }
            } else {
                //Add
                selectedSeats.append(select)
            }
        }
    }
}
