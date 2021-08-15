//
//  CommunityCell.swift
//  sharex
//
//  Created by Amr Moussa on 30/06/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class CommunityCell: UICollectionViewCell {
    
    static let cellID = "communityCell"
    let cellHeader = CellHeader()
    var imageSlider = ImageSlider()
    let commProductInfo = CommunityCellInfoView()
    let CellFooter = CommCellFooter()
    let productDesc = ProductItemLable(textAlignment: .left,NoOfLines: 0)
    let nameLabel  = ProductItemLable(textAlignment: .left,NoOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageSlider.timer.invalidate()
        
    }
    
    
    
    private func configure(){
        addSubViews(cellHeader,imageSlider,commProductInfo,
                    CellFooter,productDesc,nameLabel)
        
        let padding:CGFloat = 5
        let imageViewerHeight:CGFloat = DeviceTypes.isSmallSEAndMini ? 200:300
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            cellHeader.heightAnchor.constraint(equalToConstant: 60),
            cellHeader.widthAnchor.constraint(equalTo: widthAnchor),
            cellHeader.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageSlider.topAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: padding),
            imageSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageSlider.widthAnchor.constraint(equalTo: widthAnchor),
            imageSlider.heightAnchor.constraint(equalToConstant: imageViewerHeight),
            
            commProductInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commProductInfo.topAnchor.constraint(equalTo: imageSlider.bottomAnchor, constant: padding),
            commProductInfo.heightAnchor.constraint(equalToConstant: 60),
            commProductInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            
            CellFooter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            CellFooter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            CellFooter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            CellFooter.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding*2),
            nameLabel.topAnchor.constraint(equalTo: commProductInfo.bottomAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: padding),
            
            
            productDesc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*2),
            productDesc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            productDesc.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            //productDesc.firstBaselineAnchor.constraint(equalTo: productDesc.topAnchor)
            //productDesc.bottomAnchor.constraint(equalTo: CellFooter.topAnchor,constant: -padding)
            
            
            
            
        ])
        
        backgroundColor = .systemBackground
        
    }
    
    
    func setHeader (userID:String,date:Double){
        NetworkManager.Shared.getUserInfo(userID: userID){ [weak self] user in
            guard let self = self else {return}
            self.cellHeader.set(avatarUrl: user.avatarUrl, username:user.userName, rating: user.userRating, date: date)
            
        }
        
        
       
        
    }
    
    func setImagesSlider(productID:String){
        NetworkManager.Shared.getImagesUrlsForProduct(productID: productID) { [weak self]imgArr in
            guard let self = self else {return }
            self.imageSlider.setImages(imgArr: imgArr,Animated: true,interval: 2.0)
        }
        CellFooter.favButton.configureProduct(withProduct: productID)
        
    }
    
    func setNameAndDesc(name:String,desc:String){
        nameLabel.text = name.capitalized
        nameLabel.configureAsHeadline()
        productDesc.text = desc
        productDesc.textColor = .secondaryLabel
    }
    
    func setInfo(inGameCount:Int,totalCount:Int,shareprice:Double,originalPrice:Double){
        commProductInfo.setInfo(image: Images.commCountImage, inGame: inGameCount, total: totalCount, price: shareprice)
        
    }
    
    
    
}
