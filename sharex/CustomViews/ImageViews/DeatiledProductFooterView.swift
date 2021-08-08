//
//  DeatiledProductFooterView.swift
//  sharex
//
//  Created by Amr Moussa on 08/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class  DestailedProductFooterView: UIView {
    
    
    let commentButton = ShareButton(text: "Comment", bGColor: .systemGray5,iconImage: Images.commentImage)
    let shareButton = CommCellShareButton()
    let favButton = FavoriteButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubViews(shareButton,commentButton,favButton)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            
            favButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favButton.widthAnchor.constraint(equalTo: favButton.heightAnchor),
            
            shareButton.trailingAnchor.constraint(equalTo: favButton.leadingAnchor, constant: -padding),
            shareButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor),
        
            commentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commentButton.topAnchor.constraint(equalTo: topAnchor, constant:padding),
            commentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            commentButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -padding),
           
         
        ])
        

        
    }
    
    
}
