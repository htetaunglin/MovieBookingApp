//
//  SeatTest.swift
//  MovieBookingAppTests
//
//  Created by Htet Aung Lin on 13/07/2022.
//
@testable import MovieBookingApp
import XCTest

class SeatUnitTest: XCTestCase {
    
    var seatModel: SeatModel!
    var bookingModel: BookingInfoModel!
    var seatPresenter: MovieSeatPresenterProtocol!
    
    let mockMovie = Movie(id: 100, originalTitle: "Spider man", releaseDate: "2021-06-21", genres: ["action"], overview: "This is overview", rating: 4.8, runtime: 1, posterPath: "this is image path", casts: [])
    let mockCinema = Cinema(id: 100, name: "Cinema !", phone: "099656456455", email: "ciname1@gmail.com", address: "this is address")
    let mockDayTimeSlot = Timeslot(cinemaDayTimeslotID: 1, startTime: "2022-06-21")

    override func setUpWithError() throws {
        bookingModel = BookingInfoMockModelImpl()
        seatModel = SeatMockModelImpl()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        seatModel = nil
        bookingModel = nil
        seatPresenter = nil
    }
    
    func test_presenter_whenBookingIsNil_mustBeReturnNoBookingFound() throws {
        let viewPresenter = SeatMockViewPresenter()
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.failDelegate = { error -> Void in
            XCTAssertEqual(error, "No booking object found")
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    
    func test_presenter_whenTimeSlotIsNil_mustBeReturnNoTimeSlotFound() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.failDelegate = { error -> Void in
            XCTAssertEqual(error, "No timeSlot found")
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_whenDateIsNil_mustBeReturnNoBookingDate() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        bookingModel.getbookingInfo()?.date = nil
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.failDelegate = { error -> Void in
            XCTAssertEqual(error, "No booking date")
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_whenFetchSeat_mustBeFailedWithError_returnFromNetworkMessage() throws {
        let viewPresenter = SeatMockViewPresenter()
        seatModel = SeatMockErrorModelImpl()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.failDelegate = { error -> Void in
            XCTAssertEqual(error, "The given data was invalid.")
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_whenFetchSeat_mustBeSuccess_SeatsAreNotEmpty() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.successDelegate = { seats -> Void in
            XCTAssertFalse(seats.isEmpty)
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_selectedSeatWhatIsTaken_mustNotBeAddToSelectedSeats() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.successDelegate = { seats -> Void in
            let seat = seats[0][2]
            presenter.selectSeat(seat: seat)
            XCTAssertTrue(presenter.selectedSeats.isEmpty)
            XCTAssertEqual(presenter.bookingInfo?.totalCharges(), 0)
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
   
    func test_presenter_selectedSeatWhatIsAvailable_mustBeAddToSelectedSeats_And_totalChargesIs20() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.successDelegate = { seats -> Void in
            let seat = seats[0][3]
            presenter.selectSeat(seat: seat)
            seatExpectation.fulfill()
        }
        viewPresenter.selectedSeatDelegate = { seat in
            XCTAssertFalse(presenter.selectedSeats.isEmpty)
            XCTAssertEqual(presenter.totalSelectedCharges, 20)
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_unSelectedSeat_mustBeSelectedSeatIsZero_And_totalChargesIsZero() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.successDelegate = { seats -> Void in
            let seat = seats[0][3]
            presenter.selectSeat(seat: seat)
            seatExpectation.fulfill()
        }
        viewPresenter.selectedSeatDelegate = { seat in
            XCTAssertFalse(presenter.selectedSeats.isEmpty)
            XCTAssertEqual(presenter.totalSelectedCharges, 20)
            presenter.unselectSeat(selectedSeat: seat)
        }
        viewPresenter.unSelectedSeatDelegate = { seat in
            XCTAssertTrue(presenter.selectedSeats.isEmpty)
            XCTAssertEqual(presenter.totalSelectedCharges, 0)
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_selectedOneSeatToBooking_resultOfBookingTotalPriceIs20() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.successDelegate = { seats -> Void in
            let seat1 = seats[0][3]
            let seat2 = seats[0][4]
            presenter.selectSeat(seat: seat1)
            presenter.selectSeat(seat: seat2)
            seatExpectation.fulfill()
            presenter.setSelectedSeatToBooking()
        }
        viewPresenter.addSeatsToBookingDelegate = {
            XCTAssertEqual(presenter.bookingInfo?.totalCharges(), 40)
            let bookingSeats = presenter.bookingInfo!.seats?.map{ $0.seatName }.joined(separator: ",")
            XCTAssertEqual(bookingSeats, "A-3,A-4")
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
    }
    
    func test_presenter_removeBookingInfo_resultOfBookingOfSeatisEmpty() throws {
        let viewPresenter = SeatMockViewPresenter()
        bookingModel.createBookingInfo(mockMovie)
        bookingModel.setTimeSlot(cinema: mockCinema, cinemaDayTimeSlot: mockDayTimeSlot, date: Date.now)
        let presenter = MovieSeatPresenter(viewPresenter: viewPresenter, seatModel: seatModel, bookingModel: bookingModel)
        let seatExpectation = expectation(description: "wait for fetch seat")
        viewPresenter.successDelegate = { seats -> Void in
            let seat1 = seats[0][3]
            let seat2 = seats[0][4]
            presenter.selectSeat(seat: seat1)
            presenter.selectSeat(seat: seat2)
            seatExpectation.fulfill()
        }
        presenter.fetchSeats()
        wait(for: [seatExpectation], timeout: 1)
        presenter.setSelectedSeatToBooking()
        presenter.clearSeats();
        XCTAssertTrue(presenter.bookingInfo!.seats!.isEmpty)
    }
}

class SeatMockViewPresenter: MovieSeatViewPresenter {
    
    var successDelegate: (([[Seat]]) -> Void)?
    var failDelegate: ((String) -> Void)?
    var selectedSeatDelegate: ((Seat) -> Void)?
    var unSelectedSeatDelegate: ((Seat) -> Void)?
    var addSeatsToBookingDelegate: (() -> Void)?
    
    func onGetSeatData(data: [[Seat]]) {
        successDelegate?(data)
    }
    
    func onFailedGetSeat(error: String) {
        failDelegate?(error)
    }
    
    func onChangeSelectedSeat(seat: Seat, isAppend: Bool) {
        if isAppend {
            selectedSeatDelegate?(seat)
        } else {
            unSelectedSeatDelegate?(seat)
        }
    }
    
    func onAddSelectedSeatsToBooking() {
        addSeatsToBookingDelegate?()
    }
}

