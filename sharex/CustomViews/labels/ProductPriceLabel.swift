//
//  ProductPriceLabel.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ProductPriceLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(Size:CGFloat,color:UIColor) {
        super.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: Size)
        textColor = color
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    private func configure(){
        font = UIFont.systemFont(ofSize: 20,weight: .bold)
        
        textColor = .orange
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
