//
//  CommentCellFooter.swift
//  sharex
//
//  Created by Amr Moussa on 21/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class CommentCellFooter: UIView {
    
    let favButton = FavoriteButton()
    let likeButton = UIButton()
    let favCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure(){
        addSubViews(favButton,likeButton,favCount)
        
        translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        favCount.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*5),
            likeButton.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            likeButton.widthAnchor.constraint(equalToConstant: 100),
            
            
            favCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favCount.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favCount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favCount.heightAnchor.constraint(equalTo: favCount.widthAnchor),
            
            favButton.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            favButton.trailingAnchor.constraint(equalTo: favCount.leadingAnchor),
            favButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favButton.heightAnchor.constraint(equalTo: favButton.widthAnchor)
            
        ])
        favButton.backgroundColor = .systemBackground
    }
    
    
    func setData(favCount:Int,userLiked:Bool){
        self.favCount.text = String(favCount)
        likeButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .medium)
        userLiked ? SetLikedState():SetNotLikedState()

    }
    private func SetLikedState(){
        favButton.addStateOFImage(favOrNot: true)
        likeButton.setTitle("You liked", for: .normal)
        likeButton.setTitleColor(.orange, for: .normal)
    }
    
    
    private func SetNotLikedState(){
        favButton.addStateOFImage(favOrNot: false)
        likeButton.setTitle("Like?", for: .normal)
        likeButton.setTitleColor(.systemGray3, for: .normal)
    }
    
    
}
