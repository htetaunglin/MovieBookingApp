//
//  File.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 12/05/2022.
//

import Foundation

protocol BookingInfoModel {
    func getbookingInfo() -> BookingInfoObject?
    func createBookingInfo(_ movie: Movie)
    func setTimeSlot(cinema: Cinema, cinemaDayTimeSlot: Timeslot, date: Date)
    func setSeats(seats: [Seat])
    func clearSeats()
    func setSnacks(snacks: [Snack: Int])
    func clearSnacks()
    func setPaymentCard(card: PaymentCard)
    func clearBookingInfo(movieId: Int)
    func clearAllBookingInfo()
}

class BookingInfoModelImpl: BookingInfoModel {
    static let shared: BookingInfoModel = BookingInfoModelImpl()
    private init(){}
    private let repo: BookingInfoRepository = BookingInfoRepositoryImpl.shared
    
    private static var booking: BookingInfoObject? = nil
    
    func getbookingInfo() -> BookingInfoObject? {
        return BookingInfoModelImpl.booking
    }
    
    func createBookingInfo(_ movie: Movie) {
        repo.createBookingInfo(movie: movie) { info in
            BookingInfoModelImpl.booking = info
        }
    }
    
    func setTimeSlot(cinema: Cinema, cinemaDayTimeSlot: Timeslot, date: Date) {
        if let booking = getbookingInfo() {
            repo.setTimeSlot(movieId: booking.movieId, cinema: cinema, cinemaDayTimeSlot: cinemaDayTimeSlot, date: date) { info in
                BookingInfoModelImpl.booking = info
            }
        }
    }
    
    func setSeats(seats: [Seat]) {
        if let booking = getbookingInfo() {
            repo.setSeats(movieId: booking.movieId, timeSlotId: booking.cinemaDayTimeSlot?.cinemaDayTimeslotID ?? 0, date: booking.date!, seats: seats) { info in
                BookingInfoModelImpl.booking = info
            }
        }
    }
    
    func setSnacks(snacks: [Snack : Int]) {
        if let booking = getbookingInfo() {
            repo.setSnacks(movieId: booking.movieId, snacks: snacks){ info in
                BookingInfoModelImpl.booking = info
            }
        }
    }
    
    func setPaymentCard(card: PaymentCard) {
        if let booking = getbookingInfo() {
            repo.setPaymentCard(movieId: booking.movieId, paymentCard: card){ info in
                BookingInfoModelImpl.booking = info
            }
        }
    }
    
    func clearSeats() {
        if let booking = getbookingInfo() {
            repo.clearSeats(movieId: booking.movieId){ info in
                BookingInfoModelImpl.booking = info
            }
        }
    }
    
    func clearSnacks() {
        if let booking = getbookingInfo(){
            repo.clearSnacks(movieId: booking.movieId){ info in
                BookingInfoModelImpl.booking = info
            }
        }
    }
    
    func clearBookingInfo(movieId: Int) {
        repo.clearBookingInfo(movieId: movieId) {
            BookingInfoModelImpl.booking = nil
        }   
    }
    
    func clearAllBookingInfo() {
        repo.clearAllBookingInfo {
            BookingInfoModelImpl.booking = nil
        }
    }
}
