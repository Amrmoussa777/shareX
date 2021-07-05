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
    var imageSlider = ImageSlider(images: MockData.imageArr, withAutomaticslider: true, interval: 2.0)
    let commProductInfo = CommunityCellInfoView()
    let CellFooter = CommCellFooter()
    let productDesc = ProductItemLable(textAlignment: .left,NoOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
      addSubViews(cellHeader,imageSlider,commProductInfo,
                         CellFooter,productDesc)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            cellHeader.heightAnchor.constraint(equalToConstant: 60),
            cellHeader.widthAnchor.constraint(equalTo: widthAnchor),
            cellHeader.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageSlider.topAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: padding),
            imageSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageSlider.widthAnchor.constraint(equalTo: widthAnchor),
            imageSlider.heightAnchor.constraint(equalToConstant: 300),
            
            commProductInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commProductInfo.topAnchor.constraint(equalTo: imageSlider.bottomAnchor, constant: padding),
            commProductInfo.heightAnchor.constraint(equalToConstant: 60),
            commProductInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            
            CellFooter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            CellFooter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            CellFooter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            CellFooter.heightAnchor.constraint(equalToConstant: 50),
            
            productDesc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            productDesc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            productDesc.topAnchor.constraint(equalTo: commProductInfo.bottomAnchor, constant: padding),
            //productDesc.firstBaselineAnchor.constraint(equalTo: productDesc.topAnchor)
            //productDesc.bottomAnchor.constraint(equalTo: CellFooter.topAnchor,constant: -padding)
            
            
            
            
        ])
        
        
        
        
        
    }
    
    
    func setHeader (avatarUrl:String,userName:String,rating:Int,date:String){
        cellHeader.set(avatarUrl: avatarUrl, username: userName, rating: rating, date: date)

    }
    
    func setImagesSlider(imagesUrl:[String]){
        //imageSlider = ImageSlider(images: MockData.imageArr, withAutomaticslider: true, interval: 2.0)
    }
    
    
    func setInfo(inGameCount:Int,totalCount:Int,shareprice:Double){
        commProductInfo.setInfo(image: Images.commCountImage, inGame: 3, total: 5, price: 200.0)
    }
    
    
    
}
