//
//  BookingInfoTestModel.swift
//  MovieBookingAppTests
//
//  Created by Htet Aung Lin on 13/07/2022.
//

@testable import MovieBookingApp
import Foundation

class BookingInfoMockModelImpl: BookingInfoModel {
    
    var bookingInfo: BookingInfo?
    
    func getbookingInfo() -> BookingInfo? {
        return bookingInfo
    }
    
    func createBookingInfo(_ movie: Movie) {
        bookingInfo = BookingInfo()
        bookingInfo?.movie = movie
    }
    
    func setTimeSlot(cinema: Cinema, cinemaDayTimeSlot: Timeslot, date: Date) {
        bookingInfo?.cinema = cinema
        bookingInfo?.cinemaDayTimeSlot = cinemaDayTimeSlot
        bookingInfo?.date = date
    }
    
    func setSeats(seats: [Seat]) {
        bookingInfo?.seats = seats        
    }
    
    func clearSeats() {
        bookingInfo?.seats?.removeAll()
    }
    
    func setSnacks(snacks: [Snack : Int]) {
        
    }
    
    func clearSnacks() {
        
    }
    
    func setPaymentCard(card: PaymentCard) {
        
    }
    
    func clearBookingInfo(movieId: Int) {
        if bookingInfo?.movie?.id == movieId {
            bookingInfo = nil
        }
    }
    
    func clearAllBookingInfo() {
        bookingInfo = nil
    }
    
    
}
