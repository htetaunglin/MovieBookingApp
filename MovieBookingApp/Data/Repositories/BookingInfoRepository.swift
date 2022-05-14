//
//  BookingInfoRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 12/05/2022.
//

import Foundation

protocol BookingInfoRepository {
    func getBookingInfo(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void)
    func createBookingInfo(movie: Movie, completion: @escaping (BookingInfoObject?) -> Void)
    func setTimeSlot(movieId: Int, cinema: Cinema, cinemaDayTimeSlot: Timeslot, date: Date, completion: @escaping (BookingInfoObject?) -> Void)
    func setSeats(movieId: Int, timeSlotId: Int, date: Date, seats: [Seat], completion: @escaping (BookingInfoObject?) -> Void)
    func setSnacks(movieId: Int, snacks: [Snack: Int], completion: @escaping (BookingInfoObject?) -> Void)
    func setPaymentCard(movieId: Int, paymentCard: PaymentCard, completion: @escaping (BookingInfoObject?) -> Void)
    func clearSeats(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void)
    func clearSnacks(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void)
    
    func clearBookingInfo(movieId: Int, completion: @escaping () -> Void)
    func clearAllBookingInfo(completion: @escaping () -> Void)
}

class BookingInfoRepositoryImpl: BaseRepository, BookingInfoRepository {
    static let shared: BookingInfoRepository = BookingInfoRepositoryImpl()
    private override init() {
        super.init()
    }
    
//    func subscribeBookingInfo(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void) {
//        do {
//            try realmDB.write{
//                let _ = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId)?.observe {r in
//                    switch r {
//                    case .change(_, _):
//                        completion(self.realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId))
//                    case .deleted:
//                        debugPrint("Deleted")
//                    case .error(let error):
//                        debugPrint(error.code)
//                    }
//                }
//            }
//        } catch {
//            debugPrint(error.localizedDescription)
//        }
//    }
    
    func getBookingInfo(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void) {
        let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId)
        completion(object)
    }
    
    func createBookingInfo(movie: Movie, completion: @escaping (BookingInfoObject?) -> Void) {
        do {
            try realmDB.write{
                let obj = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movie.id)
                if obj == nil {
                    let object = BookingInfoObject()
                    object.movieId = movie.id
                    object.movie = movie.toMovieObject()
                    realmDB.add(object, update: .modified)
                    completion(object)
                } else {
                    completion(obj)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func setTimeSlot(movieId: Int, cinema: Cinema, cinemaDayTimeSlot: Timeslot, date: Date, completion: @escaping (BookingInfoObject?) -> Void) {
        do {
            try realmDB.write{
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    let cinemaObject = cinema.toCinemaObject()
                    let cinemaDayTimeSlotObject = cinemaDayTimeSlot.toTimeSlotObject()
                    realmDB.add(cinemaObject, update: .modified)
                    realmDB.add(cinemaDayTimeSlotObject, update: .modified)
                    
                    object.cinema = cinemaObject
                    object.cinemaDayTimeSlot = cinemaDayTimeSlotObject
                    object.date = date
                    realmDB.add(object, update: .modified)
                    completion(object)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func setSeats(movieId: Int, timeSlotId: Int, date: Date, seats: [Seat], completion: @escaping (BookingInfoObject?) -> Void) {
        do{
            try realmDB.write {
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    let seatObjs = seats.map{ $0.toSeatObject(timeSlotId: timeSlotId, date: date.toFormat(format: "yyyy-MM-dd")) }
                    realmDB.add(seatObjs, update: .modified)
                    object.seats.removeAll()
                    object.seats.append(objectsIn: seatObjs)
                    completion(object)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func setSnacks(movieId: Int, snacks: [Snack : Int], completion: @escaping (BookingInfoObject?) -> Void) {
        do {
            try realmDB.write {
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    let bookingSnackObjects = snacks.map{ key, value -> BookingSnackObject in
                        let bsObject = BookingSnackObject()
                        let snackObject = key.toSnackObject()
                        realmDB.add(snackObject, update: .modified)
                        bsObject.snackId = snackObject.id
                        bsObject.snack = snackObject
                        bsObject.quantity = value
                        return bsObject
                    }
                    realmDB.add(bookingSnackObjects, update: .modified)
                    object.snacks.removeAll()
                    object.snacks.append(objectsIn: bookingSnackObjects)
                    completion(object)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func setPaymentCard(movieId: Int, paymentCard: PaymentCard, completion: @escaping (BookingInfoObject?) -> Void) {
        do {
            try realmDB.write {
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    let cardObject = paymentCard.toPaymentCardObject()
                    realmDB.add(cardObject, update: .modified)
                    object.card = cardObject
                    completion(object)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func clearSeats(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void) {
        do {
            try realmDB.write {
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    object.seats.removeAll()
                    completion(object)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func clearSnacks(movieId: Int, completion: @escaping (BookingInfoObject?) -> Void) {
        do {
            try realmDB.write {
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    object.snacks.removeAll()
                    completion(object)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func clearBookingInfo(movieId: Int, completion: @escaping () -> Void) {
        do {
            try realmDB.write{
                if let object = realmDB.object(ofType: BookingInfoObject.self, forPrimaryKey: movieId) {
                    object.snacks.removeAll()
                    realmDB.delete(object)
                    let snacks = realmDB.objects(BookingSnackObject.self)
                    realmDB.delete(snacks)
                    completion()
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func clearAllBookingInfo(completion: @escaping () -> Void) {
        do {
            try realmDB.write {
                let snacks = realmDB.objects(BookingSnackObject.self)
                realmDB.delete(snacks)
                let objects = realmDB.objects(BookingInfoObject.self)
                realmDB.delete(objects)
                completion()
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
