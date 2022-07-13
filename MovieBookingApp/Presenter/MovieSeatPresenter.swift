//
//  PaymentPresenter.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 12/07/2022.
//

import Foundation

protocol MovieSeatPresenterProtocol {
    func fetchSeats()
    
    var selectedSeats: [Seat] { get }
    
    var totalSelectedCharges: Double { get }
    
    func selectSeat(seat: Seat)
    
    func unselectSeat(selectedSeat: Seat)
    
    var bookingInfo: BookingInfo? { get }
    
    func setSelectedSeatToBooking()
    
    func clearSeats()
}

class MovieSeatPresenter: MovieSeatPresenterProtocol {
    
    private var viewPresenter: MovieSeatViewPresenter
    private var movieSeatModel: SeatModel
    private var bookingModel: BookingInfoModel
    
    init(viewPresenter: MovieSeatViewPresenter, seatModel: SeatModel, bookingModel: BookingInfoModel) {
        self.viewPresenter = viewPresenter
        self.movieSeatModel = seatModel
        self.bookingModel = bookingModel
    }
    
    func fetchSeats() {
        guard let booking = bookingInfo else {
            self.viewPresenter.onFailedGetSeat(error: "No booking object found")
            return
        }
        guard let timeSlotId = booking.cinemaDayTimeSlot?.cinemaDayTimeslotID else {
            self.viewPresenter.onFailedGetSeat(error: "No timeSlot found")
            return
        }
        guard let date = booking.date?.toFormat(format: "EEEE, dd MMM") else {
            self.viewPresenter.onFailedGetSeat(error: "No booking date")
            return
        }
        movieSeatModel.getSeat(timeSlotId: timeSlotId, date: date){ result in
            switch result {
            case .success(let seats):
                self.viewPresenter.onGetSeatData(data: seats)
            case .failure(let error):
                self.viewPresenter.onFailedGetSeat(error: error)
            }
        }
    }
    
    var selectedSeats: [Seat] = []
    
    var totalSelectedCharges: Double {
        get {
            return selectedSeats.reduce(0) { previous, seat in return previous + seat.price!}
        }
    }
    
    func selectSeat(seat: Seat) {
        if(seat.type == "available") {
            selectedSeats.append(seat)
            viewPresenter.onChangeSelectedSeat(seat: seat, isAppend: true)
        }
    }
    
    func unselectSeat(selectedSeat: Seat) {
        selectedSeats.removeAll{ seat in seat.seatName == selectedSeat.seatName }
        viewPresenter.onChangeSelectedSeat(seat: selectedSeat, isAppend: false)
    }
    
    var bookingInfo: BookingInfo? {
        get {
            return bookingModel.getbookingInfo()
        }
    }
    
    func setSelectedSeatToBooking() {
        if !selectedSeats.isEmpty {
            bookingModel.setSeats(seats: selectedSeats)
            viewPresenter.onAddSelectedSeatsToBooking()
        }
    }
    
    func clearSeats() {
        bookingModel.clearSeats()
    }
}
