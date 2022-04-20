//
//  UICollectionViewX.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 21/02/2022.
//

import Foundation
import UIKit

extension UICollectionViewCell{
    static var identifier : String{
        String(describing: self)
    }
}

extension UICollectionView{
    func registerForCell(identifier: String){
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(identifier: String, indexPath: IndexPath)-> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}

