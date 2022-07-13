//
//  MovieSeatViewDelegate.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 12/07/2022.
//

import Foundation

protocol MovieSeatViewPresenter {
    func onGetSeatData(data: [[Seat]])
    
    func onFailedGetSeat(error: String)
    
    func onChangeSelectedSeat(seat: Seat, isAppend: Bool)
    
    func onAddSelectedSeatsToBooking()
}
