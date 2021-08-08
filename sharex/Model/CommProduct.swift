//
//  CommProduct.swift
//  sharex
//
//  Created by Amr Moussa on 05/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


struct CommProduct:Codable,Hashable {
    //product ID
    let id:String
    
    
    // Header Data
    let ownerID:String
    let date:Double
    
    //
    let name:String
    let descritption:String
      
    // NO. shares
    let inShares:Int
    let totalShares:Int
    
    //share price
    let sharePrice:Double
    let originalPrice:Double
    
    // people liked
    let likes:Int
    
    
    //No. comments
    let CommentsCount:Int
    
    //
    var liked:Bool
    
   /*
     mutating func getImagesLinks(){
     NetworkManager.Shared.getimagesUrls(productID: id)
 } */
    
    
    
    
    
    
    
    
    
    
}

