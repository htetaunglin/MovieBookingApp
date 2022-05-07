//
//  CheckoutModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation

protocol TicketModel {
    func checkout(cinemaDayTimeSlotId: Int,
                  row: String,
                  seatNumber: String,
                  bookingDate: String,
                  totalPrice: Double,
                  movieId: Int,
                  cardId: Int,
                  cinemaId: Int,
                  snacks: [SnackRequest],
                  completion: @escaping (MBAResult<MovieTicket>) -> Void)
}

class TicketModelImpl: BaseModel, TicketModel {
    static let shared = TicketModelImpl()
    private override init(){}
    
    func checkout(cinemaDayTimeSlotId: Int, row: String, seatNumber: String, bookingDate: String, totalPrice: Double, movieId: Int, cardId: Int, cinemaId: Int, snacks: [SnackRequest], completion: @escaping (MBAResult<MovieTicket>) -> Void) {
        if let token = UserModelImpl.userToken {
            networkAgent.checkout(token: token, cinemaDayTimeSlotId: cinemaDayTimeSlotId, row: row, seatNumber: seatNumber, bookingDate: bookingDate, totalPrice: totalPrice, movieId: movieId, cardId: cardId, cinemaId: cinemaId, snacks: snacks){ result in
                switch result {
                case .success(let response):
                    if let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure("Cannot checkout"))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure("Token not found"))
        }
    }
}
