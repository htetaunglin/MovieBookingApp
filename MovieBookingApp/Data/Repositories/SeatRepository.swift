//
//  SeatRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 11/05/2022.
//

import Foundation

protocol SeatRepository {
    func saveSeats(timeSlotId: Int, date: String, seats: [Seat])
    func getSeats(timeSlotId: Int, date: String, completion: @escaping ([Seat]) -> Void)
}

class SeatRepositoryImpl: BaseRepository, SeatRepository {
    static let shared: SeatRepository = SeatRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func saveSeats(timeSlotId: Int, date: String, seats: [Seat]) {
        do {
            try realmDB.write {
                let objects = seats.map{ $0.toSeatObject(timeSlotId: timeSlotId, date: date) }
                realmDB.add(objects, update: .modified)
                let object = realmDB.object(ofType: TimeSlotObject.self, forPrimaryKey: timeSlotId)
                object?.seats.append(objectsIn: objects)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getSeats(timeSlotId: Int, date: String, completion: @escaping ([Seat]) -> Void) {
        let object = realmDB.object(ofType: TimeSlotObject.self, forPrimaryKey: timeSlotId)
        debugPrint(object?.seats);
        completion(object?.seats.map{ $0.toSeat() } ?? [])
    }
    
}
