//
//  FavoriteButton.swift
//  sharex
//
//  Created by Amr Moussa on 20/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addTappedGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let notFavImage = Images.notFavImage
        setImage(notFavImage, for: .normal)
        imageView?.tintColor = .orange
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func addTappedGesture(){
        addTarget(self, action: #selector(flipIcon), for: .touchUpInside)
    }
    
    @objc private func flipIcon(){
        let FavImage = imageView?.image == Images.notFavImage ? Images.FavImage:Images.notFavImage
        setImage(FavImage, for: .normal)
    }
}
