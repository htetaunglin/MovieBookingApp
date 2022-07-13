//
//  File.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 12/05/2022.
//

import Foundation

protocol BookingInfoModel {
    func getbookingInfo() -> BookingInfo?
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
    
    private var booking: BookingInfo? = nil
    
    func getbookingInfo() -> BookingInfo? {
        return booking
    }
    
    func createBookingInfo(_ movie: Movie) {
        repo.createBookingInfo(movie: movie) { info in
            self.booking = info?.toBookingInfo()
        }
    }
    
    func setTimeSlot(cinema: Cinema, cinemaDayTimeSlot: Timeslot, date: Date) {
        if let booking = getbookingInfo() {
            if let movie = booking.movie {
                repo.setTimeSlot(movieId: movie.id, cinema: cinema, cinemaDayTimeSlot: cinemaDayTimeSlot, date: date) { info in
                    self.booking = info?.toBookingInfo()
                }
            }
            
        }
    }
    
    func setSeats(seats: [Seat]) {
        if let booking = getbookingInfo() {
            if let movie = booking.movie {
                repo.setSeats(movieId: movie.id, timeSlotId: booking.cinemaDayTimeSlot?.cinemaDayTimeslotID ?? 0, date: booking.date!, seats: seats) { info in
                    self.booking = info?.toBookingInfo()
                }
            }
        }
    }
    
    func setSnacks(snacks: [Snack : Int]) {
        if let booking = getbookingInfo() {
            if let movie = booking.movie {
                repo.setSnacks(movieId: movie.id, snacks: snacks){ info in
                    self.booking = info?.toBookingInfo()
                }
            }
        }
    }
    
    func setPaymentCard(card: PaymentCard) {
        if let booking = getbookingInfo() {
            if let movie = booking.movie {
                repo.setPaymentCard(movieId: movie.id, paymentCard: card){ info in
                    self.booking = info?.toBookingInfo()
                }
            }
        }
    }
    
    func clearSeats() {
        if let booking = getbookingInfo() {
            if let movie = booking.movie {
                repo.clearSeats(movieId: movie.id){ info in
                    self.booking = info?.toBookingInfo()
                }
            }
        }
    }
    
    func clearSnacks() {
        if let booking = getbookingInfo() {
            if let movie = booking.movie {
                repo.clearSnacks(movieId: movie.id){ info in
                    self.booking = info?.toBookingInfo()
                }
            }
        }
    }
    
    func clearBookingInfo(movieId: Int) {
        repo.clearBookingInfo(movieId: movieId) {
            self.booking = nil
        }   
    }
    
    func clearAllBookingInfo() {
        repo.clearAllBookingInfo {
            self.booking = nil
        }
    }
}
