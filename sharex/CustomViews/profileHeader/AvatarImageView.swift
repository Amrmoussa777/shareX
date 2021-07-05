//
//  AvatarImageView.swift
//  sharex
//
//  Created by Amr Moussa on 01/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    
   // let cache = NetworkManager.shared.cache
    let placeholderImage = Images.avatarPlaceholer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
  
}
