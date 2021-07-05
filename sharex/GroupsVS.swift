//
//  GroupsVS.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import SwiftUI

class GroupsVS: UIViewController {
    
    
    var CommCollecView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var commProducts:[CommProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.commProducts = MockData.commProductsArr
        
        configureCollectioView()
        
        
        
        
    }
    
    
    private func configureCollectioView(){
        
        layout.scrollDirection = .vertical
        CommCollecView = UICollectionView(frame:view.bounds , collectionViewLayout: layout)
        CommCollecView.delegate = self
        CommCollecView.dataSource = self
        CommCollecView.collectionViewLayout = layout
        CommCollecView.showsVerticalScrollIndicator = false
        CommCollecView.isPagingEnabled = true
        CommCollecView.register(CommunityCell.self, forCellWithReuseIdentifier: CommunityCell.cellID)
        
        view.addSubview(CommCollecView)
        
        CommCollecView.pinToSuperViewSafeArea(in: view)
        
    }
    
    
    
    
}



extension GroupsVS : UICollectionViewDelegate, UICollectionViewDataSource
                     ,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return commProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityCell.cellID, for: indexPath) as! CommunityCell
        let product = commProducts[indexPath.row]
        
        cell.setHeader(avatarUrl: product.avatarUrl, userName: product.userName, rating: product.userRating, date: product.date)
        cell.setImagesSlider(imagesUrl: product.images)
        cell.setInfo(inGameCount: product.inShares, totalCount: product.totalShares, shareprice: product.sharePrice)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
