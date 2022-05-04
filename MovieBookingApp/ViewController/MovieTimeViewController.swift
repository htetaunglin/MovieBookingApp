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
    
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightTimeSlot: NSLayoutConstraint!
    
    @IBOutlet weak var viewTime: UIView!
    
    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var collectionViewTimeSlot: UICollectionView!
    
    private let cinemaModel: CinemaModel = CinemaModelImpl.shared
    
    private var dates: [Date] = [] {
        didSet {
            collectionViewDays.reloadData()
            if !dates.isEmpty {
                chooseDate = dates.first
            }
        }
    }
    
    private var cinemas: [Cinema] = [] {
        didSet {
            if !cinemas.isEmpty {
                chooseCinema = cinemas.first
            }
            collectionViewHeightAvailableIn.constant = CGFloat(56 * ((cinemas.count + 1) / 3))
        }
    }
    
    private var cinemaTimeSlots: [CinemaTimeSlot] = []
    
    private var chooseDate: Date? {
        didSet {
            // fetch network
            if let date = chooseDate {
                fetchTimeSlots(movieId: 1, date: date.toFormat(format: "yyyy-MM-dd"))
            }
            collectionViewDays.reloadData()
        }
    }
    
    
    private var chooseCinema: Cinema? {
        didSet {
            collectionViewAvailableIn.reloadData()
            chooseCinemaTimeSlot = cinemaTimeSlots.first { cinema in
                return cinema.cinemaID == chooseCinema?.id
            }
            
        }
    }
    
    private var chooseCinemaTimeSlot: CinemaTimeSlot? {
        didSet{
            if let cinemaTimeSlot = chooseCinemaTimeSlot {
                cinemaName.text = cinemaTimeSlot.cinema ?? ""
                timeSlots = cinemaTimeSlot.timeslots ?? []
            }
        }
    }
    
    private var timeSlots: [Timeslot] = [] {
        didSet {
            collectionViewTimeSlot.reloadData()
            collectionViewHeightTimeSlot.constant = CGFloat(56 * ((timeSlots.count + 1) / 3))
        }
    }
    
    private var chooseTimeSlot: Timeslot? {
        didSet {
            collectionViewTimeSlot.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setUpDataSourceAndDelegate()
        setUpHeightForCollectionView()
        setCornerViewTime()
        // Build UI Data
        generateDateTime()
    }
    
    private func setCornerViewTime(){
        viewTime.clipsToBounds = true
        viewTime.layer.cornerRadius = 24
        viewTime.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    fileprivate func registerCells(){
        collectionViewDays.registerForCell(identifier: DaysCollectionViewCell.identifier)
        collectionViewAvailableIn.registerForCell(identifier: TimeCollectionViewCell.identifier)
        collectionViewTimeSlot.registerForCell(identifier: TimeCollectionViewCell.identifier)
    }
    
    fileprivate func setUpDataSourceAndDelegate(){
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewTimeSlot.dataSource = self
        collectionViewTimeSlot.delegate = self
    }
    
    fileprivate func setUpHeightForCollectionView(){
        collectionViewHeightAvailableIn.constant = 56
        collectionViewHeightTimeSlot.constant = 56 * 2
        //View Reload
        self.view.layoutIfNeeded()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        navigateToMovieSeatViewController()
    }
    
    
    fileprivate func generateDateTime(){
        let calendar = NSCalendar.current
        var startDay = calendar.startOfDay(for: Date())
        for _ in 1...7{
            if let date = calendar.date(byAdding: .day, value: 1, to: startDay){
                startDay = date
                dates.append(date)
            }
        }
    }
    
    fileprivate func fetchCinemas(){
        cinemaModel.getCinemas{ [weak self] result in
            switch result {
            case .success(let cinemas):
                self?.cinemas = cinemas
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func fetchTimeSlots(movieId: Int, date: String){
        cinemaModel.getTimeSlots(movieId: movieId, date: date) {[weak self] result in
            switch result {
            case .success(let times):
                self?.cinemaTimeSlots = times
                self?.fetchCinemas()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}


extension MovieTimeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewDays {
            return dates.count
        }else if collectionView == collectionViewAvailableIn{
            return cinemas.count
        } else if collectionView == collectionViewTimeSlot {
            return timeSlots.count
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewDays {
            let cell = collectionView.dequeueCell(identifier: DaysCollectionViewCell.identifier, indexPath: indexPath) as DaysCollectionViewCell
            cell.date = dates[indexPath.row]
            cell.isSelect = dates[indexPath.row] == chooseDate
            return cell;
        }else if collectionView == collectionViewAvailableIn{
            let cell = collectionView.dequeueCell(identifier: TimeCollectionViewCell.identifier, indexPath: indexPath) as TimeCollectionViewCell
            cell.isSelect = cinemas[indexPath.row].id == chooseCinema?.id
            cell.label.text = cinemas[indexPath.row].name
            return cell
        } else if collectionView == collectionViewTimeSlot {
            let cell = collectionView.dequeueCell(identifier: TimeCollectionViewCell.identifier, indexPath: indexPath) as TimeCollectionViewCell
            cell.label.text = timeSlots[indexPath.row].startTime ?? ""
            cell.isSelect = timeSlots[indexPath.row].cinemaDayTimeslotID == chooseTimeSlot?.cinemaDayTimeslotID
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewDays {
            chooseDate = dates[indexPath.row]
        } else  if collectionView == collectionViewAvailableIn {
            chooseCinema = cinemas[indexPath.row]
            chooseTimeSlot = nil
        } else if collectionView == collectionViewTimeSlot {
            chooseTimeSlot = timeSlots[indexPath.row]
        }
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
