//
//  HomeVC.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

enum section {
    case main
}
class HomeVC: UIViewController {
   
    
    
    var products:[CommProduct] = []
    
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<section, CommProduct>!
    let createSharingView = CreateNewSharingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getProducts()
        configureCreateView()
        addObservers()
    }
    
    deinit {deleteObservers()}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
    }
    
    
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutBuilder.createColumnsFlowLayout(in: view, columns: 2))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(ProductItemCell.self, forCellWithReuseIdentifier: ProductItemCell.cellIdentifier)
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexpath, product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.cellIdentifier, for: indexpath) as! ProductItemCell
            cell.setProduct(product: product)
            cell.buttonDelegate = self
            return cell
        })
    }
    
    private func getProducts(){
        let loadingView = showLoadingView()
        NetworkManager.Shared.getProduncts { [weak self]result in
            guard let self  = self else{return}
            
            self.dismissLoadingView(view: loadingView)
            switch(result){
            
            case .failure(let error):
               //SHow Error state veiw
                print(error)
            case .success(let products):
            self.products = products
            self.updateItems(with: products)
                
            }
            
        }
        
    }
    


    private func updateSingleItem(product:CommProduct){
        let index = products.firstIndex {
            $0.id == product.id
        }
        
        guard let index = index else {
            return
        }
        
        guard products[index] != product else {
         return
        }
        
        products[index] = product
        updateItems(with: products)
       
    }
    
    private func updateItems(with products:[CommProduct]){
        var snapshot = NSDiffableDataSourceSnapshot<section,CommProduct>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    private func configureCreateView(){
        view.addSubview(createSharingView)
        let safeArea = view.safeAreaLayoutGuide
        let padding:CGFloat = 10
        NSLayoutConstraint.activate([
            createSharingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createSharingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createSharingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding),
            createSharingView.heightAnchor.constraint(equalToConstant: 70),
        ])
        if #available(iOS 14, *) {
            createSharingView.createSharing.addTarget(self, action: #selector(createSharingTapped), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
    }
    
    

    
}

extension HomeVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Product Tapped")
        //showDetailedProduct(product: products[indexPath.row])
        showOverView(product: products[indexPath.row],delegate: self)
    }
    
    
}

extension HomeVC:viewDetailedViewProtocol{
    func showDetailedWith(product: CommProduct) {
        showDetailedProduct(product: product)
        
    }
    
   
    
    
}

extension HomeVC: getButtonDelegate{
    func getButtonTapped(indexPath: IndexPath?) {
        guard let id = indexPath?.row else{return}
        showOverView(product: products[id],delegate: self)
    }
}


extension HomeVC{
    private func addObservers(){
        addLoginObserever()
        addLoggOutObserever()
        addProductChangedObserever()
        addNewProductObserever()
    }
    
    private func deleteObservers(){
        NotificationCenter.default.removeObserver(self, name: .recievedProduct, object: nil)
        deleteLoginObserver()
        deleteLoggOutObserver()
        deleteProductChangedObserver()
        deleteNewProductObserver()
    }
    
     override func prductsChagned(_ notification:Notification){
        guard let data = notification.userInfo as? [String:CommProduct] else {
            return
        }
        
        guard let product  = data["product"] else {
            return
        }
        
        updateSingleItem(product: product)
    }
    
    override func loggedIn(_ notification: Notification) {
        collectionView.reloadData()
    }
    
    override func loggedOut(_ notification: Notification) {
        collectionView.reloadData()
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
            
            self.products.append(product)
            self.updateItems(with: self.products)
            
        }
    }
      
  
    
    
}

//    MARK:- Create New sharing
extension HomeVC{
    @available(iOS 14, *)
    @objc func createSharingTapped(){
        let createVC = CreateNewSharingVC()
        DispatchQueue.main.async {
            self.present(createVC, animated: true)
        }
    }
  
}

