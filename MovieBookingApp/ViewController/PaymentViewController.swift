//
//  PaymentViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 26/02/2022.
//

import Foundation
import UIKit
import UPCarouselFlowLayout

class PaymentViewController: UIViewController{
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var cardCarousel: UICollectionView!
    
    let userModel: UserModel = UserModelImpl.shared
    let ticketModel: TicketModel = TicketModelImpl.shared
    let bookingModel: BookingInfoModel = BookingInfoModelImpl.shared
    
    var paymentCards: [PaymentCard] = [] {
        didSet {
            if !paymentCards.isEmpty {
                chooseCard = paymentCards.first
            }
            cardCarousel.isHidden = paymentCards.isEmpty
            cardCarousel.reloadData()
        }
    }
    
    var chooseCard: PaymentCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCardCarousel()
        decorateCard()
        fetchProfile()
        dataBind()
    }
    
    private func registerCardCarousel(){
        cardCarousel.registerForCell(identifier: PayCardCarouselCollectionViewCell.identifier)
        cardCarousel.dataSource = self
        cardCarousel.delegate = self
    }
    
    private func decorateCard(){
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width * 0.8, height: 200)
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.sideItemAlpha = 0.5
        layout.spacingMode = .overlap(visibleOffset: view.bounds.width * 0.05)
        cardCarousel.collectionViewLayout = layout
    }
    
    @IBAction func onClickAddNewCard(_ sender: Any) {
        navigateToAddNewCardViewController(delegate: self)
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        if let card = chooseCard {
            bookingModel.setPaymentCard(card: card)
        }
        
        if let booking = bookingModel.getbookingInfo() {
            let cinemaDayTimeSlotId : Int = booking.cinemaDayTimeSlot?.cinemaDayTimeslotID ?? 0
            let row: String = Array(Set(booking.seats.map{ $0.symbol })).joined(separator: ",")
            let seatNumbers: String = Array(Set(booking.seats.map{ $0.seatName })).joined(separator: ",")
            let bookingDate: String = booking.date?.toFormat(format: "yyyy-MM-dd") ?? ""
            let totalPrice: Double = 0
            let movieId: Int = booking.movieId
            let cardId: Int = chooseCard?.id ?? 0
            let cinemaId: Int = booking.cinema?.id ?? 0
            let snacks: [SnackRequest] = booking.snacks.map{ $0.toSnackRequest() }
        
            showLoadingAlert()
            ticketModel.checkout(cinemaDayTimeSlotId: cinemaDayTimeSlotId, row: row, seatNumber: seatNumbers, bookingDate: bookingDate, totalPrice: totalPrice, movieId: movieId, cardId: cardId, cinemaId: cinemaId, snacks: snacks){[weak self] result in
                switch result {
                case .success(let ticket):
                    self?.bookingModel.clearBookingInfo(movieId: movieId)
                    //Dimiss loading
                    self?.presentedViewController?.dismiss(animated: false) {
                        self?.navigateToTicketViewController(ticket: ticket)
                    }
                case .failure(let error):
                    self?.presentedViewController?.dismiss(animated: false) {
                        self?.showMessageAlert(error)
                    }
                }
            }
        }
    }
    
    
    func fetchProfile(){
        userModel.getCurrentUser{ [weak self] result in
            switch result {
            case .success(let user):
                self?.paymentCards = user.paymentCard ?? []
            case .failure(let error):
                debugPrint("Error \(error)")
            }
        }
    }
    
    func dataBind(){
        lblAmount.text = "$ \(bookingModel.getbookingInfo()?.totalCharges() ?? 0)"
        paymentCards = userModel.user?.paymentCard ?? []
        cardCarousel.isHidden = paymentCards.isEmpty
    }
}

extension PaymentViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: PayCardCarouselCollectionViewCell.identifier, indexPath: indexPath) as PayCardCarouselCollectionViewCell
        cell.paymentCard = paymentCards[indexPath.row]
        return cell
    }
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chooseCard = paymentCards[indexPath.row]
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.cardCarousel.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = layout.itemSize.width
        let offset = scrollView.contentOffset.x
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView(self.cardCarousel, didSelectItemAt: indexPath)
    }
}

extension PaymentViewController: AddNewCardDelegate {
    func onAddNewCard(cards: [PaymentCard]) {
        paymentCards = cards
    }
}
