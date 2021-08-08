//
//  ChatFooterView.swift
//  sharex
//
//  Created by Amr Moussa on 30/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class ChatFooterView: UIView {
    
    let textFeild = ShareTextFeild(placeHolder: "Write your message...", placeholderImage: Images.swriteImage!)
    let sendButton = SendButton(bGColor: .orange, iconImage: Images.sendImage)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubViews(textFeild,sendButton)
        
        let padding:CGFloat = 10
        
        NSLayoutConstraint.activate([
        
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            
            textFeild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            textFeild.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            textFeild.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            textFeild.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -padding)
        
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
        RoundCorners()
        backgroundColor = UIColor.systemGray5.withAlphaComponent(0.5)
        textFeild.becomeFirstResponder()
        textFeild.returnKeyType = .send
    }
    
}

