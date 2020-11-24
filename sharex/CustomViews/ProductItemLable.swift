//
//  ProductItemLable.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ProductItemLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(textAlignment:NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        text = "Iphone 11 64GB with face time and 4GB RAM Iphone 11 64GB with face time and 4GB RAM Iphone 11 64GB with face time and 4GB RAM ."
        textColor = .label
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        numberOfLines = 3
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
}
