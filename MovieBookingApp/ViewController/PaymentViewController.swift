//
//  PaymentViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 26/02/2022.
//

import Foundation
import UIKit
import UPCarouselFlowLayout

class PaymentViewController: UIViewController{

    @IBOutlet weak var cardCarousel: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCardCarousel()
        decorateCard()
    }
    
    private func registerCardCarousel(){
        cardCarousel.dataSource = self
        cardCarousel.registerForCell(identifier: PayCardCarouselCollectionViewCell.identifier)
    }
    
    private func decorateCard(){
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width * 0.8, height: 200)
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.sideItemAlpha = 0.5
        layout.spacingMode = .overlap(visibleOffset: view.bounds.width * 0.05)
        cardCarousel.collectionViewLayout = layout
    }
    
    @IBAction func onClickAddNewCard(_ sender: Any) {
        navigateToAddNewCardViewController()
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        navigateToTicketViewController()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PaymentViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: PayCardCarouselCollectionViewCell.identifier, indexPath: indexPath)
        return cell
    }
    
}
