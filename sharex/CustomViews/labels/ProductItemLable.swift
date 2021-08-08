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
    
    init(textAlignment:NSTextAlignment,NoOfLines:Int = 2,size:CGFloat = 17) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        numberOfLines = NoOfLines
        configure(size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ size:CGFloat){
        
        
        
        text = "Product description"
        textColor = .label
        font = UIFont.systemFont(ofSize: size, weight: .regular)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setText(text:String){
        DispatchQueue.main.async {
            self.text = text
        }
       
    }
    
    func configureAsHeadline(){
        self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.backgroundColor = .systemGray5
    }
    
    func configureAsProfileHeadline(){
        self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.textColor = .label
    }
    
    func configureAsConversationMessage(){
        self.textColor = .tertiaryLabel
    }
    
    func configureAstelephoneLabel(){
        self.textColor = .tertiaryLabel
    }
    
    
}
