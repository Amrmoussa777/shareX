//
//  CellHeader.swift
//  sharex
//
//  Created by Amr Moussa on 30/06/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit
import SwiftUI

class  CellHeader: UIView {
    
    let userAvatar = AvatarImageView()
    let userName   = UserNameLabel()
    let ratingView = RatingUIView()
    let dateLabel  = DateLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func configure(){
        addSubViews(userAvatar,userName,
                    ratingView,dateLabel)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            userAvatar.heightAnchor.constraint(equalToConstant: 50),
            userAvatar.widthAnchor.constraint(equalToConstant: 50),
            userAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            userAvatar.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: padding),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            userName.heightAnchor.constraint(equalToConstant: 20),
            userName.widthAnchor.constraint(equalToConstant: 100),
            
            ratingView.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 0),
            ratingView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 2),
            ratingView.heightAnchor.constraint(equalToConstant: 20),
            ratingView.widthAnchor.constraint(equalTo: userName.widthAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 100)
            
        
        ])
        translatesAutoresizingMaskIntoConstraints = false
    }
    
   
    func set(avatarUrl:String,username:String,
             rating:Int,date:String){
        userAvatar.downloadImage(fromURL: avatarUrl)
        ratingView.addRating(rating: rating)
        dateLabel.setDate(date: date)
        userName.setName(name: username)
    }
}
