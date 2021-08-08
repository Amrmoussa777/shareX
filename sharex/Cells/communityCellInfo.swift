//
//  communityCellInfo.swift
//  sharex
//
//  Created by Amr Moussa on 04/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit
import SwiftUI


class CommunityCellInfoView:UIView{
    
    let indvidualsImgView = UIImageView()
    let totalShares      = UILabel()
    let inGameShares     = UILabel()
    let priceLabel       = ProductPriceLabel()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        addSubViews(indvidualsImgView,inGameShares,
                    totalShares,priceLabel)
        priceLabel.textAlignment = .right
        
        indvidualsImgView.tintColor = .orange
        indvidualsImgView.backgroundColor = .systemGray5
        indvidualsImgView.RoundCorners()
        indvidualsImgView.contentMode = .center
        bringSubviewToFront(indvidualsImgView)
        
        
        inGameShares.backgroundColor = .systemGray5
        inGameShares.RoundCorners()
        inGameShares.textAlignment = .center
        inGameShares.font = UIFont.systemFont(ofSize: 20, weight: .regular)

        
        
        totalShares.backgroundColor = .systemBackground
        totalShares.RoundCorners()
        totalShares.textAlignment = .center
        totalShares.AddStroke(color: .systemGray5)
        totalShares.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        indvidualsImgView.translatesAutoresizingMaskIntoConstraints = false
        totalShares.translatesAutoresizingMaskIntoConstraints = false
        inGameShares.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat  = 5
        
        NSLayoutConstraint.activate([
            
            indvidualsImgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            indvidualsImgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indvidualsImgView.heightAnchor.constraint(equalToConstant: 56),
            indvidualsImgView.widthAnchor.constraint(equalTo:indvidualsImgView.heightAnchor ,constant: 8),
            
            inGameShares.leadingAnchor.constraint(equalTo: indvidualsImgView.trailingAnchor, constant: -3*padding),
            inGameShares.centerYAnchor.constraint(equalTo: centerYAnchor),
            inGameShares.widthAnchor.constraint(equalToConstant: 60),
            inGameShares.heightAnchor.constraint(equalToConstant: 50),
            
            totalShares.leadingAnchor.constraint(equalTo: inGameShares.trailingAnchor, constant: -3*padding),
            totalShares.centerYAnchor.constraint(equalTo: centerYAnchor),
            totalShares.heightAnchor.constraint(equalToConstant: 50),
            totalShares.widthAnchor.constraint(equalToConstant: 60),
            
            
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            priceLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -padding),
            priceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)

        ])
        
        
        
    }
    
    func setInfo(image:UIImage?,inGame:Int,total:Int,price:Double){
        indvidualsImgView.image = image
        inGameShares.text = String(inGame)
        totalShares.text = String(total)
        priceLabel.text = String(price) + " EGP"
     
    }
    // FUNC: To triger label Stroke to change colors when switching to dark mode
    //  i think UIlabel() stroke has issue with dark mode .
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
            
            totalShares.changeStroke(color: .systemGray5)
           }
       }
    }

}


struct communityCellInfo_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
