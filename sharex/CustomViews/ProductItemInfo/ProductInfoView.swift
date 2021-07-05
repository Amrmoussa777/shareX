//
//  ProductInfoView.swift
//  sharex
//
//  Created by Amr Moussa on 22/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ProductInfoView: UIView {

    let symbolImageView = UIImageView()
    let countLabel = ProductCountLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(symbolImageView,countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .orange
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: -padding),
            symbolImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            symbolImageView.widthAnchor.constraint(equalTo: symbolImageView.heightAnchor),
            
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: padding*2),
            countLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: -padding),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding)
            
        ])
//        Didnt use translatesAutoresizingMaskIntoConstraints as long as it would be implemented inside stackview and wouldnt have specaial constrains
   
    }
    
    
    func setInfo(cardType: ProdcutCardTypes,count:Int){
        switch cardType {
        case .communityCount:
            symbolImageView.image = Images.commCountImage
        case .soldCount:
            symbolImageView.image = Images.soldcountImage
        }
        countLabel.text = String(count)
    }

    
}





