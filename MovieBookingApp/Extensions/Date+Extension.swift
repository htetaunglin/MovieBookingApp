//
//  Date+Extension.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 05/05/2022.
//

import Foundation

extension Date {
    func toFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
        
    }
}
