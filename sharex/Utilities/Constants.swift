//
//  Constants.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

enum TabbarImages{
    static let homeTabbarItemImage = UIImage(systemName: "house")
    static let groupTabbarItemImage = UIImage(systemName: "person.3")
    static let chatTabbarItemImage = UIImage(systemName: "message")
    static let ordersTabbarItemImage = UIImage(systemName: "cart")
    static let accountnavbaritem = UIImage(systemName: "person.circle")

}
enum Images {
    static let productImgPlaceholder = UIImage(systemName: "photo.fill")
    static let sliderImgPlaceholder = UIImage(systemName: "photo.on.rectangle.angled")
    static let notFavImage =  UIImage(systemName: "heart")
    static let FavImage =  UIImage(systemName: "heart.fill")
    static let bagImage = UIImage(systemName: "bag")
    static let commCountImage = UIImage(systemName: "person.2")
    static let soldcountImage = UIImage(systemName: "cart")
    static let avatarPlaceholer = UIImage(named:"userAvatar")
    static let commInfoImage = UIImage(systemName: "person.3")
    static let commentImage = UIImage(systemName: "text.bubble")
    static let shareImage = UIImage(systemName: "arrowshape.turn.up.forward")
    static let errorButton = UIImage(systemName: "checkmark.shield.fill")
    
    static let loginImage = UIImage(named: "loginAvatar")
    static let registerImage = UIImage(named: "registerAvatar")
    static let createNewProductAvatar = UIImage(named: "createNewProductAvatar")
    
    
    
    static let emailImage = UIImage(systemName: "envelope")
    static let passwordImage = UIImage(systemName: "lock.shield" )
    static let userNameImage = UIImage(systemName: "person")
    static let phoneImage = UIImage(systemName: "phone")
    static let plusImage = UIImage(systemName: "plus")
    static let checkMarkImage = UIImage(systemName: "checkmark.circle")
    static let sendImage = UIImage(systemName: "paperplane")
    static let swriteImage = UIImage(systemName: "pencil")
    static let faildAndReloadImage = UIImage(systemName: "arrow.counterclockwise")
    static let dollarSign = UIImage(systemName: "dollarsign.circle")
   
    
    
    
    static let nextButton = UIImage(systemName: "arrow.forward" )
    static let logOut = UIImage(systemName: "arrow.left" )
    
    
    
    
    
}

enum AlertImages{
    
    static let lockImage = UIImage(systemName: "lock")
    static let unlockImage = UIImage(systemName: "lock.open")
    static let registerImage = UIImage(systemName: "arrow.up.doc.fill")
    
    static let topAlertImage = UIImage(named: "ErrorAvatar")
    
    

    
    
}
enum  alertMessages:String,Error {
    case noUserFound = "Proceeed to sign In"
  
}


enum ProdcutCardTypes{
    case communityCount
    case soldCount
}

struct FireStoreDB {
    
    
    struct Product{
        
        static let date = "date"
       static let ownerID = "ownerID"
       static let name = "name"
        static let inShares = "inshares"
        static let totalShares = "totalShares"
        static let sharePrice = "sharePrice"
        static let descritption = "description"
        static let originalPrice = "originalPrice"
        static let sharesUsers = "sharesUsers"
        static let imageUrls = "imgUrls"
        static let imageUrlsChild = "url"
        static let comments = "comments"
        static let likes = "likes"
        
    }
    
    
    struct  User {
        static let avatarLink = "avatarLink"
        static let name = "name"
        static let rating = "rating"
        static let email = "email"
        static let likesColelction  = "likes"
        static let productsIn  = "productsIn"
        static let lastSeen = "lastSeen"
        static let phoneNumber = "phoneNumber"
    }
    
    struct Comment {
        static let body = "commentBody"
        static let timeSTamp = "timeStamp"
        static let ownerId = "ownerID"
        static let likesCount = "likesCount"
        static let likes = "likes"
        
    }
    
    struct conversation{
        static let messages = "messages"
        
    }
    struct message{
        static let messageBody = "messageBody"
        static let senderID = "senderID"
        static let timeStamp = "timeStamp"
    }
    
}

enum userLoginStatus {
    case loggedin
    case tappedRegisterButton
    case registered
}


enum cellTypes {
    case comment
    case conversation
}

extension Notification.Name{
    static let recievedProduct = Notification.Name("recievedProduct")
    static let loggedIn = Notification.Name("loggedIn")
    static let loggedOut = Notification.Name("loggedOut")
    static let newProductAdded = Notification.Name("newProductAdded")
}
