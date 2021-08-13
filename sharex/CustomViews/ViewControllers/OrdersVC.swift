//
//  ProfileVC.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class OrdersVC: UIViewController{
    
    
    var ordersCollectionView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    var orders:[CommProduct] = []
    let padding:CGFloat = 5
    
    var emptyStateView:EmptyStateView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        configureLayout()
        getUsersOrders()
        addObservers()
    }
    
    deinit {
        deleteObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
    }
    
    
    private func configureLayout(){
        ordersCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
        ordersCollectionView.collectionViewLayout = layout
        ordersCollectionView.showsVerticalScrollIndicator = false
        ordersCollectionView.register(ProductItemCell.self, forCellWithReuseIdentifier: ProductItemCell.cellIdentifier)
        ordersCollectionView.backgroundColor = .systemBackground
        
        view.addSubview(ordersCollectionView)
        ordersCollectionView.pinToSuperViewEdges(in: self.view)
    }
    
    private func getUsersOrders(){
        NetworkManager.Shared.getUsersOrders {[weak self] orders in
            guard let self = self else {return}
            guard orders != [] else{
                self.emptyStateView?.removeFromSuperview()
                self.emptyStateView =  self.view.showEmptyState(img: Images.loginImage!, message: "You have no orders \n please go and join some sharings that would be addedhere automatically 😁")
                return
            }
            
            guard self.orders != orders else{
                return
            }
            
            DispatchQueue.main.async {
                self.emptyStateView?.removeFromSuperview()
                self.orders = orders
                self.ordersCollectionView.reloadData()
            }
            
        }
    }
    
    
    
}


extension OrdersVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ordersCollectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.cellIdentifier, for: indexPath) as! ProductItemCell
        cell.setProduct(product: orders[indexPath.row])
        cell.configureAsOrderItem()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        showOverView(product: order, delegate: self,Joined: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - padding*3 ) / 2 //split collection veiw to two columns.
        return CGSize(width: width, height: width * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


extension  OrdersVC: viewDetailedViewProtocol{
    func showDetailedWith(product: CommProduct) {
        showDetailedProduct(product: product)
    }
}

extension OrdersVC{
    func addObservers(){
        addLoginObserever()
        addLoggOutObserever()
        addProductChangedObserever()
        addNewProductObserever()
        addNewProduuctShareAdded()
    }
    
    func deleteObservers(){
        deleteLoginObserver()
        deleteLoggOutObserver()
        deleteProductChangedObserver()
        deleteNewProductObserver()
        deleteNewProduuctShareAdded()
    }
    
    override func prductsChagned(_ notification:Notification){
        guard let data = notification.userInfo as? [String:CommProduct] else {
            return
        }
        
        guard let product  = data["product"] else {
            return
        }
        
        let index = orders.firstIndex{
            $0.id  == product.id
        }
        
        guard let index = index else {
            return
        }
        
        let indexPath  = IndexPath(item: index, section: 0)
        ordersCollectionView.reloadItems(at: [indexPath])
        
        
    }
    
    
    override func loggedIn(_ notification: Notification) {
        getUsersOrders()
    }
    
    override func loggedOut(_ notification: Notification) {
        getUsersOrders()
        
    }
    
    override func NewProductAdded(_ notification: Notification) {
        guard let data = notification.userInfo as? [String:String] else {
            return
        }
        
        guard let productID  = data["productID"] else {
            return
        }
        
        NetworkManager.Shared.getSingleProduct(productID: productID) {[weak self] optProduct in
            guard let self = self else {return}
            guard let product = optProduct else{
                return
            }
            
            self.orders.append(product)
            self.ordersCollectionView.reloadData()
            
        }
    }
    
    override func newShareAdded(_ notification: Notification) {
        guard let data = notification.userInfo as? [String:String] else {
            return
        }
        
        guard let productID  = data["productID"] else {
            return
        }
        NetworkManager.Shared.getSingleProduct(productID: productID) {[weak self] optProduct in
            guard let self = self else {return}
            guard let product = optProduct else{
                return
            }
            
            self.orders.append(product)
            self.ordersCollectionView.reloadData()
            
        } 
    }
    
    
}
