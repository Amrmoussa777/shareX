//
//  CommProduct.swift
//  sharex
//
//  Created by Amr Moussa on 05/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


struct CommProduct:Codable {
    
    // Header Data
    let userName:String
    let userRating:Int
    let date:String
    let avatarUrl:String
  
    //image slider
    let images:[String]
    
    // NO. shares
    let inShares:Int
    let totalShares:Int
    
    //share price
    let sharePrice:Double
    
    // people liked
    let likes:Int
    
    //No. comments
    let CommentsCount:Int
    
    
    
    
    
    
    
    
    
    
    
}

