//
//  CellFooter.swift
//  sharex
//
//  Created by Amr Moussa on 05/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class CommCellFooter: UIView {
    
    let getButton = ShareButton(text: "Join Now", bGColor: .orange)
    let commentButton = ShareButton(text: "Comment", bGColor: .systemGray5,iconImage: Images.commentImage)
    let favButton = FavoriteButton()
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        
        
        addSubViews(getButton,commentButton,favButton)
        
        let padding :CGFloat = 5
        
        NSLayoutConstraint.activate([
        
            getButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            getButton.topAnchor.constraint(equalTo: topAnchor, constant:padding),
            getButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            getButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
           
            favButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favButton.widthAnchor.constraint(equalTo: favButton.heightAnchor),
         
            commentButton.leadingAnchor.constraint(equalTo: getButton.trailingAnchor, constant: padding),
            commentButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            commentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            commentButton.trailingAnchor.constraint(equalTo: favButton.leadingAnchor,constant: -padding)
            
            
            
            
        
        ])
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
}
