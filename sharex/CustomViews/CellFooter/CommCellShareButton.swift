//
//  CommCellShareButton.swift
//  sharex
//
//  Created by Amr Moussa on 05/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class CommCellShareButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let shareImage = Images.shareImage
        setImage(shareImage, for: .normal)
        imageView?.tintColor = .orange
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}

