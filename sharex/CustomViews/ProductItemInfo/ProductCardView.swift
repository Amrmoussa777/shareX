//
//  ProductCardView.swift
//  sharex
//
//  Created by Amr Moussa on 22/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ProductCardView: UIView {

    let stacKView = UIStackView()
    let communityView = ProductInfoView()
    let soldVeiw  = ProductInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configrue()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configrue(){
        
        stacKView.translatesAutoresizingMaskIntoConstraints = false
        stacKView.axis = .horizontal
        stacKView.distribution = .equalSpacing
        
        stacKView.addArrangedSubview(communityView)
        stacKView.addArrangedSubview(soldVeiw)
        
        addSubview(stacKView)
        
        pinToSuperViewEdges(in: self)
        
        
    }
    
    func addDataCartView(CommuityCount:Int,soldCount:Int){
        communityView.setInfo(cardType: .communityCount, count: CommuityCount)
        soldVeiw.setInfo(cardType: .soldCount, count: soldCount)
    }
    
}
