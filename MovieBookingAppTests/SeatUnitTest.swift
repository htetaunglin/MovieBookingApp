//
//  SeatTest.swift
//  MovieBookingAppTests
//
//  Created by Htet Aung Lin on 13/07/2022.
//
@testable import MovieBookingApp
import XCTest

class SeatUnitTest: XCTestCase {
    
    var seatModel = SeatTestModelImpl.shared
    var bookingModel: BookingInfoModel = BookingInfoTestModelImpl.shared
    var seatPresenter: MovieSeatPresenterProtocol!
    
    var seats: [[Seat]] = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bookingModel.createBookingInfo(Movie(id: 100, originalTitle: "Spider man", releaseDate: "2021-06-21", genres: ["action"], overview: "This is overview", rating: 4.8, runtime: 1, posterPath: "this is image path", casts: []))
        bookingModel.setTimeSlot(cinema: Cinema(id: 100, name: "Cinema !", phone: "099656456455", email: "ciname1@gmail.com", address: "this is address"), cinemaDayTimeSlot: Timeslot(cinemaDayTimeslotID: 1, startTime: "2022-06-21"), date: Date.now)
        seatPresenter = MovieSeatPresenter(viewPresenter: self, seatModel: seatModel, bookingModel: bookingModel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_select_seat_process() throws {
        seatPresenter.fetchSeats()
        XCTAssertFalse(seats.isEmpty)
        
        let seat1 = seats[0][2] // A-2 -> taken seat
        let seat2 = seats[0][3] // A-3
        let seat3 = seats[0][4] // A-4
        let seat4 = seats[0][5] // A-5
        
        seatPresenter.selectSeat(seat: seat1)
        XCTAssertEqual(seatPresenter.totalSelectedCharges, 0)
        seatPresenter.selectSeat(seat: seat2)
        XCTAssertEqual(seatPresenter.totalSelectedCharges, 20)
        seatPresenter.selectSeat(seat: seat3)
        XCTAssertEqual(seatPresenter.totalSelectedCharges, 40)
        seatPresenter.selectSeat(seat: seat4)
        XCTAssertEqual(seatPresenter.totalSelectedCharges, 60)
        
        XCTAssertFalse(seatPresenter.selectedSeats.contains(where: { $0.seatName == seat1.seatName }))
        
        XCTAssertFalse(seatPresenter.selectedSeats.isEmpty)
        XCTAssertTrue(seatPresenter.selectedSeats.count == 3)
        
        seatPresenter.unselectSeat(selectedSeat: seat2)
        XCTAssertEqual(seatPresenter.totalSelectedCharges, 40)
        
        XCTAssertFalse(seatPresenter.selectedSeats.isEmpty)
        XCTAssertTrue(seatPresenter.selectedSeats.count == 2)
        
        seatPresenter.setSelectedSeatToBooking()
        XCTAssertFalse(seatPresenter.bookingInfo!.seats!.isEmpty)
        XCTAssertEqual(seatPresenter.bookingInfo?.totalCharges(), 40)
        
        let bookingSeats = seatPresenter.bookingInfo!.seats?.map{ $0.seatName }.joined(separator: ",")
        XCTAssertEqual(bookingSeats, "A-4,A-5")
    }
}

extension SeatUnitTest: MovieSeatViewPresenter {
    
    func onGetSeatData(data: [[Seat]]) {
        self.seats = data
    }
    
    func onFailedGetSeat(error: String) {
        
    }
    
    func onChangeSelectedSeat(seat: Seat, isAppend: Bool) {
        
    }
    
    func onAddSelectedSeatsToBooking() {
        
    }
    
    
}
