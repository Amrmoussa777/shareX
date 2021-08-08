//
//  UIVC+Ext.swift
//  sharex
//
//  Created by Amr Moussa on 30/06/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

extension UIViewController{
    
    
  
    
   @objc func rightBarItemTapped(){
        //handle accoutn icon tapped
        let accountVC = CurentUserProfile()
        accountVC.parentVC = self
        present(accountVC, animated: true)
        
    
    }
    
    @objc func dissmisVC(){
       dismiss(animated: true)
    
     }
    
    
    func showDetailedProduct<T:Codable>(product:T){
        let detailedProductVC = DetailedProductVC()
        detailedProductVC.product = product  as? CommProduct
        
        navigationController?.pushViewController(detailedProductVC, animated: true)
        navigationItem.backBarButtonItem?.tintColor = .orange
    }
    
    func showOverView(product:CommProduct,delegate:viewDetailedViewProtocol,Joined:Bool = false){
        let overViewVC = ProductOverViewVC()
        overViewVC.product = product
        overViewVC.delegate = delegate
        
        if(Joined){
            overViewVC.configureAsJoined()
        }
        
        present(overViewVC, animated: true)
        
    }
    
    
    //var containerView: UIView!
    
    func showLoadingView() -> UIView {
        let containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        return containerView
    }
    
    func dismissLoadingView(view:UIView) {
        DispatchQueue.main.async {
            view.removeFromSuperview()
        }
    }
    
    func presentLoginVC(delegateHandler:loginStatusProtocol){
        let loginVC  = LoginVC.shared
        loginVC.delegate = delegateHandler
        present(loginVC, animated: true)
        
    }
    func showRegisterVC(delegateHandler:loginStatusProtocol){
        let registerVC = RegisterVC.shared
           registerVC.delegate = delegateHandler
        present(registerVC, animated: true)
    }
   
    func checkForProductsUpdate(products:[CommProduct])->([CommProduct]?){
        let objects:[CommProduct] = NetworkManager.Shared.productsCache.map{$0.value}
        print(objects == products ? "Not changed":"Changed")
        return objects == products ?   nil:objects
    }
    
    

    
}


extension UIViewController{
//LOGIN
    func addLoginObserever(){
        NotificationCenter.default.addObserver(self, selector: #selector(loggedIn(_:)), name: .loggedIn, object: nil)
    }
     func deleteLoginObserver(){
        NotificationCenter.default.removeObserver(self, name: .loggedIn, object: nil)
    }
    
    @objc func loggedIn(_ notification:Notification){}
    
//LOGOUT
    func addLoggOutObserever(){
        NotificationCenter.default.addObserver(self, selector: #selector(loggedOut(_:)), name: .loggedOut, object: nil)
    }
     func deleteLoggOutObserver(){
        NotificationCenter.default.removeObserver(self, name: .loggedOut, object: nil)
    }
    
    @objc func loggedOut(_ notification:Notification){}
    
//NEW PRODUCT ADDED
    func addNewProductObserever(){
        NotificationCenter.default.addObserver(self, selector: #selector(NewProductAdded(_:)), name: .newProductAdded, object: nil)
    }
     func deleteNewProductObserver(){
        NotificationCenter.default.removeObserver(self, name: .newProductAdded, object: nil)
    }
    
    @objc func NewProductAdded(_ notification:Notification){}
    
//    PRODUCT CHANGED
    func addProductChangedObserever(){
        NotificationCenter.default.addObserver(self, selector: #selector(prductsChagned(_:)), name: .recievedProduct, object: nil)
    }
     func deleteProductChangedObserver(){
        NotificationCenter.default.removeObserver(self, name: .recievedProduct, object: nil)
    }
    
    @objc func prductsChagned(_ notification:Notification){}
    
}
