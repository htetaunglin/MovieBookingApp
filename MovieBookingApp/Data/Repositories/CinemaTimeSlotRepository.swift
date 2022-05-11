//
//  CinemaTimeSlotRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation


protocol CinemaTimeSlotRepository {
    func saveCinemaTimeSlots(movieId: Int, date: String, timeSlots: [CinemaTimeSlot])
    func getCinemaTimeSlotsByMovie(movieId: Int, date: String, completion: @escaping ([CinemaTimeSlot]) -> Void)
//    func savePaymentMethods(methods: [PaymentMethod])
//    func getPaymentMethods(completion: @escaping ([PaymentMethod]) -> Void)
}

class CinemaTimeSlotRepositoryImpl: BaseRepository, CinemaTimeSlotRepository {
    static let shared: CinemaTimeSlotRepository = CinemaTimeSlotRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func saveCinemaTimeSlots(movieId: Int, date: String, timeSlots: [CinemaTimeSlot]) {
        do {
            try realmDB.write {
                realmDB.add(timeSlots.map{ $0.toCinemaTimeSlotObject(movieId: movieId, date: date) }, update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getCinemaTimeSlotsByMovie(movieId: Int, date: String, completion: @escaping ([CinemaTimeSlot]) -> Void) {
        let predicate = NSPredicate(format: "movieId == \(movieId) AND date == %@", date)
        let list = realmDB.objects(CinemaTimeSlotObject.self).filter(predicate)
        completion(list.map{ $0.toCinemaTimeSlot() })
    }
}
