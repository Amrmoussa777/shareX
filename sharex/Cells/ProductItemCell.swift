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
    let productDescLabel   = ProductItemLable(textAlignment: .left)
    let commuPriceLabel    = ProductPriceLabel(Size: 20, color: .orange)
    let indivPriceLabel    = ProductPriceLabel(Size: 16, color: .lightGray)
    let productInfoView    = ProductCardView()
    let getButton         = ShareButton(text: "Join now", bGColor:.orange)
    let favButton         = FavoriteButton()
    
    var buttonDelegate:getButtonDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        favButton.addStateOFImage(favOrNot: false)
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
        
        getButton.addTarget(self, action: #selector(getButtonTapped), for: .touchUpInside)
    }
   
    func setProduct(product:CommProduct){
        commuPriceLabel.text = String(product.sharePrice) + " EGP"
        indivPriceLabel.text = String(product.originalPrice) + " EGP"
        productDescLabel.setText(text: product.name.capitalized) 
        productInfoView.addDataCartView(CommuityCount: product.totalShares, soldCount:  product.inShares)
        getProductImgUrls(productID: product.id)
        favButton.configureProduct(withProduct: product.id)
        
    }
    
    private func getProductImgUrls(productID :String){
        NetworkManager.Shared.getImagesUrlsForProduct(productID: productID) {[weak self] imgUrls in
            guard let self  = self else {return}
            guard imgUrls != [] else {
                return
            }
            self.ProductImageView.downloadImage(fromURL: imgUrls[0])
            
        }
        
    }
    @objc func getButtonTapped(){
        buttonDelegate?.getButtonTapped(indexPath: collectionView?.indexPath(for: self))
    }
    
    func configureAsOrderItem(){
        getButton.isEnabled = false
        getButton.backgroundColor = .blue
        getButton.setTitle("Joined", for: .normal)
        getButton.setImage(Images.bagImage, for: .normal)
    }
   
    
    
}


protocol getButtonDelegate {
    func getButtonTapped(indexPath:IndexPath?)
}
