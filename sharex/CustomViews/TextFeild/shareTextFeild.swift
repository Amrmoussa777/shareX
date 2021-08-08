//
//  shareTextFeild.swift
//  sharex
//
//  Created by Amr Moussa on 15/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

                
class ShareTextFeild:UITextField{
    
    lazy var originalPassword = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolder:String,placeholderImage:UIImage) {
        super.init(frame: .zero)
        configure(placeHolder,placeholderImage)
        
        
    }
    
    
    private func configure(_ plaHolder:String,_ placeHolderImage:UIImage){
        
        let attachment = NSTextAttachment()
        attachment.image = placeHolderImage.withTintColor(.systemGray2)
        attachment.bounds = CGRect(x: 0, y: -5, width: 23, height: 20)
        
        let attachmentStr = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "   ")
        myString.append(attachmentStr)
        let myString1 = NSMutableAttributedString(string:"  " + plaHolder,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)])
        myString.append(myString1)
        self.attributedPlaceholder = myString
        
        textAlignment = .center
        
        
        RoundCorners()
        AddStroke(color: .systemGray6)
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
   
    
    
    
}

extension ShareTextFeild{
    func configurePasswordView(){
        tintColor = UIColor.clear
        
        addTarget(self, action: #selector(updateTextFeild), for: .editingChanged)
        
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    @objc private func updateTextFeild(){
        
        let txtCount = text?.count ?? 0
         
        
        let txt = text?.last ?? " "

        
        if txtCount > originalPassword.count{
            originalPassword.append(txt)
            text  = String(repeating: "•", count: text?.count ?? 0 )
        }
        else if txtCount <= originalPassword.count{
            originalPassword.removeLast()
            
        }
       
        
    }
}
