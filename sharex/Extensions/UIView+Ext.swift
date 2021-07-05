//
//  UIView+Ext.swift
//  sharex
//
//  Created by Amr Moussa on 20/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import SwiftUI

extension UIView {
    
    
    func addSubViews(_ views:UIView...){
        for view in views {addSubview(view)}
    }
    
    
    func pinToSuperViewEdges(in view:UIView){
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func pinToSuperViewSafeArea(in view:UIView){
        let safeArea = view.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            topAnchor.constraint(equalTo: safeArea.topAnchor),
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    func RoundCorners(){
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func AddStroke(color:UIColor){
       layer.borderWidth = 2
        layer.borderColor = color.cgColor
        
    }
    func changeStroke(color:UIColor){
        layer.borderColor = color.cgColor
    }
   
    

  /*     func addRatingView(rating:Int){
     // swiftUI view inside UIkit view
     let swiftUIView = RatingView(rating: .constant(rating))
         let hostingController = UIHostingController(rootView: swiftUIView)

     hostingController.view.backgroundColor = .none
         addSubview(hostingController.view)

         /// Setup the constraints to update the SwiftUI view boundaries.
         hostingController.view.translatesAutoresizingMaskIntoConstraints = false
         let constraints = [
             hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
             hostingController.view.leftAnchor.constraint(equalTo: self.leftAnchor),
             self.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
             self.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
         ]
             
         NSLayoutConstraint.activate(constraints)

        
     
     
 }
 */

    
}
