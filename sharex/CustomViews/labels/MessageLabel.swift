//
//  MessageLabel.swift
//  sharex
//
//  Created by Amr Moussa on 30/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class MessageLabel :UILabel{
    
    
    let padding:CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        RoundCorners()
        font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textColor = .label
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureAsSender(){
        
        backgroundColor = UIColor.orange.withAlphaComponent(0.7)
    }
    
    func configureAsReciever(){
        
        backgroundColor = UIColor.systemGray5.withAlphaComponent(0.5)
        
    }
    
    func setMessage(messagebody:String){
        DispatchQueue.main.async {
            self.text = messagebody
            self.sizeToFit()
        }
       
    }
    
    override func drawText(in rect: CGRect) {
       
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        super.drawText(in: rect.inset(by: insets))
    }
   
    override var intrinsicContentSize: CGSize{
        get{
            var contentSize = super.intrinsicContentSize
                   contentSize.height += padding + padding
                   contentSize.width += padding + padding
                   return contentSize
        }
    }
    
    
}
