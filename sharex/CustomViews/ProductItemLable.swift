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
    
    init(textAlignment:NSTextAlignment,NoOfLines:Int = 3) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        numberOfLines = NoOfLines
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        //let descWord = NSAttributedString(string: "Description:", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold) ])
        
        
        text = "Iphone 11 64GB with face time and 4GB RAM Iphone 11 64GB with face time and 4GB RAM Iphone 11 64GB with face time and 4GB RAM ."
        textColor = .label
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setText(text:String){
        self.text = text
    }
    
    
    
}
