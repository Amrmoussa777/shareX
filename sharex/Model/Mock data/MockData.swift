//
//  MockData.swift
//  sharex
//
//  Created by Amr Moussa on 03/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


struct  MockData {
    
    static let imageArr:[UIImage] = [
    UIImage(named: "productImageIphone-1")!,
        UIImage(named: "iphone12-3")!,
        UIImage(named: "iphone12-4")!,
        UIImage(named: "productImageIphone-2")!
    ]
    
    
    static let commProductsArr:[CommProduct] = [
        CommProduct(userName: "Amr Moussa", userRating: 3, date: "June 2021", avatarUrl: "/placholder", images: [], inShares: 2, totalShares: 6, sharePrice: 350, likes: 2, CommentsCount: 4),
        CommProduct(userName: "Mohamed Ibrahim",userRating: 2, date: "May 2021", avatarUrl: "/placholder", images: [], inShares: 1, totalShares: 4, sharePrice: 450, likes: 2, CommentsCount: 4),
        CommProduct(userName: "Ali mo", userRating: 4, date: "April 2021", avatarUrl: "/placholder", images: [], inShares: 3, totalShares: 5, sharePrice: 460, likes: 2, CommentsCount: 4),
        CommProduct(userName: "Sayed foad", userRating: 5, date: "July 2021", avatarUrl: "/placholder", images: [], inShares: 1, totalShares: 3, sharePrice: 480, likes: 2, CommentsCount: 4),
        CommProduct(userName: "Ali Moussa", userRating: 2, date: "March 2021", avatarUrl: "/placholder", images: [], inShares: 4, totalShares: 7, sharePrice: 500, likes: 2, CommentsCount: 4)
    ]
    
    
}
