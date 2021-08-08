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
        configureCollectioView()
        getCommProducts()
        addObservers()
    }
    
    deinit {deleteObservers()}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
//        checkUpdate
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
    
    private func getCommProducts(){
        let loadingScreen = showLoadingView()
        
        NetworkManager.Shared.getProduncts{ [weak self]result in
            guard let self  = self else {return}
            self.dismissLoadingView(view: loadingScreen)
            switch (result){
            case .failure(let error):
              print(error)
            case .success(let products):
                self.updateCollectionView(products: products)
            }
        }
        
    }
    
//
//    private func checkUpdates(){
//        guard let UpdatedProducts = checkForProductsUpdate(products: commProducts) else {
//            return
//        }
//        commProducts = UpdatedProducts
//        updateCollectionView(products:UpdatedProducts)
//    }
//
    private func updateCollectionView(products:[CommProduct]){
        self.commProducts = products
        self.CommCollecView.reloadData()
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
        cell.setHeader(userID:product.ownerID , date: product.date)
        cell.setImagesSlider(productID: product.id)
        cell.setInfo(inGameCount: product.inShares, totalCount: product.totalShares, shareprice: product.sharePrice,originalPrice: product.originalPrice)
        cell.setNameAndDesc(name: product.name, desc: product.descritption)
        cell.CellFooter.commentButton.tag = indexPath.row
        cell.CellFooter.getButton.tag = indexPath.row
        cell.CellFooter.commentButton.addTarget(self, action: #selector(joinCommentTapped), for: .touchUpInside)
        cell.CellFooter.getButton.addTarget(self, action: #selector(joinCommentTapped), for: .touchUpInside)
        
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

extension GroupsVS{
    
    @objc func joinCommentTapped(_ sender:AnyObject){
        guard let id = sender.tag else {return}
        showDetailedProduct(product: commProducts[id])
    }
    
}

extension GroupsVS{
    private func addObservers(){
        addLoginObserever()
        addLoggOutObserever()
        addProductChangedObserever()
        addNewProductObserever()

    }
    
    private func deleteObservers(){
        deleteProductChangedObserver()
        deleteLoginObserver()
        deleteLoggOutObserver()
        deleteNewProductObserver()
    }
    
    override func prductsChagned(_ notification:Notification){
        guard let data = notification.userInfo as? [String:CommProduct] else {
            return
        }
        
        guard let product  = data["product"] else {
            return
        }
        
        let index = commProducts.firstIndex{
            $0.id  == product.id
        }
        
        guard let index = index else {
            return
        }
        
        let indexPath  = IndexPath(item: index, section: 0)
        CommCollecView.reloadItems(at: [indexPath])
    }
    
    override func loggedIn(_ notification: Notification) {
        CommCollecView.reloadData()
    }
    
    override func loggedOut(_ notification: Notification) {
        CommCollecView.reloadData()
    }
    
    override func NewProductAdded(_ notification: Notification) {
        guard let data = notification.userInfo as? [String:String] else {
            return
        }
        
        guard let productID  = data["productID"] else {
            return
        }
        
        NetworkManager.Shared.getSingleProduct(productID: productID) {[weak self] optCommProduct in
            guard let self = self else {return}
            guard let product = optCommProduct else {return}
            self.commProducts.append(product)
            self.CommCollecView.reloadData()
        }
        
        
    }
      
}
