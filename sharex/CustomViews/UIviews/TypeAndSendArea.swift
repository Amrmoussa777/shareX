//
//  TypeAndSendArea.swift
//  sharex
//
//  Created by Amr Moussa on 22/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class TypeAndSendArea: UIView {
    
    let sendButton = SendButton(bGColor: .orange, iconImage: Images.sendImage)
    let textFeild = ShareTextFeild(placeHolder: " Comment or Ask about a product ....", placeholderImage: Images.commentImage!)
    
    var product:CommProduct?
    
    var commentAddedDelegate:commentAdded?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubViews(sendButton,textFeild)
        let padding:CGFloat = 5
    
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            
            textFeild.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            textFeild.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            textFeild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            textFeild.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor,constant: -padding),
            
        
        ])
        
    }
    
    
    func configureAddComment(withProduct product:CommProduct){
        self.product = product
        sendButton.addTarget(self, action: #selector(addSendTapped), for: .touchUpInside)
    }
    
    @objc func addSendTapped(){
        guard let commentBody = textFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) else{return}
        
        if (commentBody.isEmpty) {return}
        
        NetworkManager.Shared.addComment(withProduct: product!, commentBody: commentBody) {[weak self] isSaved in
            guard let self = self else {return}
            switch(isSaved){
            case false:
                print("Not Saved")
            case true:
                self.textFeild.text = ""
                self.commentAddedDelegate?.UpdateComments()
                
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
}


protocol commentAdded {
    func UpdateComments()
    
}


