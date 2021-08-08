//
//  FavoriteButton.swift
//  sharex
//
//  Created by Amr Moussa on 20/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    var id:String?
    var type:favButtonType?
    var productID:String?
    var favCommentDelegate:commentlikedDeleagte?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
//        addTappedGesture()
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
    
    func configureProduct(withProduct productID:String){
        id = productID
        type = .Product
        addTarget(self, action: #selector(addFavProduct), for: .touchUpInside)
        getlikedOrNot(productID:productID)
    }
    
    func configureComment(withComment commentID:String,productID:String){
        id = commentID
        type = .Comment
        self.productID = productID
        addTarget(self, action: #selector(addFavComment), for: .touchUpInside)
    }
  
    @objc func addFavProduct(){
        flipIcon()
        NetworkManager.Shared.addFavProduct(productID: id ?? "") { [weak self]isSaved in
            guard let self = self else {return}
            switch (isSaved){
            case false:
                self.flipIcon()
            case true:
                break
            }
        }
    }
    
    @objc func addFavComment(){
        flipIcon()
        NetworkManager.Shared.addFavComment(commentID: id ?? "", productID: productID ?? "") {[weak self] isSaved in
            guard let self = self else {return}
            switch (isSaved){
            case false:
                self.flipIcon()
            case true:
                self.favCommentDelegate?.reloadCommnetFooter(commentID: self.id ?? "", productID: self.productID ?? "",liked: true)
            }
        }

    }
    
//
//    private func addTappedGesture(){
//        addTarget(self, action: #selector(flipIcon), for: .touchUpInside)
//    }
//
    @objc private func flipIcon(){
        let FavImage = imageView?.image == Images.notFavImage ? Images.FavImage:Images.notFavImage
        setImage(FavImage, for: .normal)
    }
    
    
    
    
    
    
    ///
    func addStateOFImage(favOrNot:Bool){
        let FavImage = favOrNot ? Images.FavImage:Images.notFavImage
        setImage(FavImage, for: .normal)
    }
    
    
    private func getlikedOrNot(productID:String){
        NetworkManager.Shared.getProductLikedOrNot(productID: productID) {[weak self] liked in
            guard let self = self else {return}
            self.addStateOFImage(favOrNot: liked)
        }
    }
    
}


enum favButtonType{
    case Comment
    case Product
}

protocol commentlikedDeleagte{
    func reloadCommnetFooter(commentID: String, productID: String,liked:Bool)
}
