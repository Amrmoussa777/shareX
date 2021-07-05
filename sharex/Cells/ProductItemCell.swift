//
//  ProductItemCell.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ProductItemCell: UICollectionViewCell {
    
    static let cellIdentifier = "ProductItemCell"
    
    let ProductImageView   = ProductAvatar(frame: .zero)
    let productDescLabel   = ProductItemLable(textAlignment: .justified)
    let commuPriceLabel    = ProductPriceLabel(Size: 20, color: .orange)
    let indivPriceLabel    = ProductPriceLabel(Size: 16, color: .lightGray)
    let productInfoView    = ProductCardView()
    let getButton         = ShareButton(text: "get now", bGColor:.orange)
    let favButton         = FavoriteButton()
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(){

        contentView.addSubViews(ProductImageView,
                                productDescLabel,
                                commuPriceLabel,
                                indivPriceLabel,
                                productInfoView,
                                getButton,
                                favButton)
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            ProductImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            ProductImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            ProductImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ProductImageView.heightAnchor.constraint(equalTo: ProductImageView.widthAnchor),
            
            productDescLabel.topAnchor.constraint(equalTo: ProductImageView.bottomAnchor, constant: padding),
            productDescLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            productDescLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            productDescLabel.heightAnchor.constraint(equalToConstant: 50),
            
            commuPriceLabel.topAnchor.constraint(equalTo: productDescLabel.bottomAnchor),
            commuPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            commuPriceLabel.heightAnchor.constraint(equalToConstant: 30),
            commuPriceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),
            
            indivPriceLabel.topAnchor.constraint(equalTo: commuPriceLabel.bottomAnchor),
            indivPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            indivPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            indivPriceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            productInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            productInfoView.topAnchor.constraint(equalTo: indivPriceLabel.bottomAnchor, constant: padding),
            productInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            productInfoView.bottomAnchor.constraint(equalTo: getButton.topAnchor, constant: -padding),
            
            getButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            getButton.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -padding),
            getButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.70),
            getButton.heightAnchor.constraint(equalToConstant: 40),
            
            favButton.leadingAnchor.constraint(equalTo: getButton.trailingAnchor, constant: padding),
            favButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            favButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            favButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
     
    func setProduct(product:Product){
        commuPriceLabel.text = String(product.price) + " EGP"
        indivPriceLabel.text = String(product.price * 1.5) + " EGP"
        productInfoView.addDataCartView(CommuityCount: Int(product.price*20), soldCount: Int(product.price*10))
    }
    
    private func downloadImage(url :String){
        
        
    }

}
