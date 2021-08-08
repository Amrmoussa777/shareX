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
        Images.sliderImgPlaceholder!,
    ]
    
    
  
    
    static let usersArr:[User] =  [
        
        User(id: "1", userName: "Amr Mousa", userRating: 2, avatarUrl: "https://firebasestorage.googleapis.com/v0/b/sharex-dd269.appspot.com/o/users%2FuserAvatar2.png?alt=media&token=190bc562-48f0-4962-b414-047237dadfc5",email:"", phoneNumber: "01067865284"),
//        User(id: "2", userName: "Ali ibrahim", userRating: 2, avatarUrl: "",email:""),
//        User(id: "3", userName: "mohamed sayed ", userRating: 2, avatarUrl: "",email:""),
//        User(id: "4", userName: "walid ibrahim", userRating: 2, avatarUrl: "",email:""),
//        User(id: "1", userName: "Amr Mousa", userRating: 2, avatarUrl: "",email:""),
//        User(id: "2", userName: "Ali ibrahim", userRating: 2, avatarUrl: "",email:""),
//        User(id: "3", userName: "mohamed sayed ", userRating: 2, avatarUrl: "",email:""),
    ]
    
    
    
    static let  comments:[Comment] = [
        Comment(commentID: "1", commetOwnerID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", commentDate: 1606795611, commentBody: "this product need updates and how we could gain this product after completksdjsdjskdjlsdlsjdlsjjjjjjjjjjjjjjjjjion  gain this product after completksdjsdjskdjlsdlsjdlsjjjjjjjjjjjjjjjjjion  gain this product after completksdjsdjskdjlsdlsjdlsjjjjjjjjjjjjjjjjjion  gain this product after completksdjsdjskdjlsdlsjdlsjjjjjjjjjjjjjjjjjion ", favCount: 22, favOrNot: true),
        Comment(commentID: "2", commetOwnerID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", commentDate: 1626785611, commentBody: "this product need updates and how we could gain this product after completion 2 ", favCount: 21, favOrNot: false),
        Comment(commentID: "3", commetOwnerID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", commentDate: 1626795611, commentBody: "this product need updates and how we could gain this product after completion  3", favCount: 23, favOrNot: true),
        Comment(commentID: "1", commetOwnerID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", commentDate: 1606795611, commentBody: "this product need updates and how we could gain this product after completion ", favCount: 22, favOrNot: true),
        Comment(commentID: "2", commetOwnerID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", commentDate: 1626785611, commentBody: "this product need updates and how we could gain this product after completion 2 ", favCount: 21, favOrNot: false),
        Comment(commentID: "3", commetOwnerID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", commentDate: 1626795611, commentBody: "this product need updates and how we could gain this product after completion  3", favCount: 23, favOrNot: true)
    
    ]
//    
//    static let conversations:[Conversation] = [
//    Conversation(id: "", avatarUrl: "https://firebasestorage.googleapis.com/v0/b/sharex-dd269.appspot.com/o/pluralSite1.jpeg?alt=media&token=ec91b981-078d-4797-ba27-311ff35c7d65", name: "Plulrr site new mdeooedmksddjsco jsdcjsd ujdiscosd c"),
//        
//    Conversation(id: "", avatarUrl: "https://firebasestorage.googleapis.com/v0/b/sharex-dd269.appspot.com/o/pluralSite1.jpeg?alt=media&token=ec91b981-078d-4797-ba27-311ff35c7d65", name: "Plulrr site new mdeooedmksddjsco jsdcjsd ujdiscosd c"),
//    
//    Conversation(id: "", avatarUrl: "https://firebasestorage.googleapis.com/v0/b/sharex-dd269.appspot.com/o/pluralSite1.jpeg?alt=media&token=ec91b981-078d-4797-ba27-311ff35c7d65", name: "Plulrr site new mdeooedmksddjsco jsdcjsd ujdiscosd c"),
//    
//    Conversation(id: "", avatarUrl: "https://firebasestorage.googleapis.com/v0/b/sharex-dd269.appspot.com/o/pluralSite1.jpeg?alt=media&token=ec91b981-078d-4797-ba27-311ff35c7d65", name: "Plulrr site new mdeooedmksddjsco jsdcjsd ujdiscosd c")
//    ]

    static let messages:[Message] = [
    Message(id: "1", senderID: "F90NkVSpxqOJ3WiiCYB88GIptYA2", textBody: "New message How about this product New message How about this productNew message How about this productNew message How about this productNew message How about this productNew message How about this product", timeStamp: 232442232),
        Message(id: "2", senderID: "FEg0a47XVCVrGajXv35IeiNHKvC3", textBody: "New message How about this productNew message How about this productNew message How about this productNew message How about this  ", timeStamp: 0),
        Message(id: "3", senderID: "FLT8CFANa56Wj7ccplVK", textBody: "New message.", timeStamp: 897898798979),
        Message(id: "4", senderID: "FEg0a47XVCVrGajXv35IeiNHKvC3", textBody: "New message How about thisNew message How about this productNew message How about this productNew message How about this productNew message How about this productNew message How about this productNew message How about this product product", timeStamp: 9879989798),
    ]
}
