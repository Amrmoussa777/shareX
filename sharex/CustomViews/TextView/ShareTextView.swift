//
//  ShareTextView.swift
//  sharex
//
//  Created by Amr Moussa on 02/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

//
//  shareTextFeild.swift
//  sharex
//
//  Created by Amr Moussa on 15/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

                
class ShareTextView:UITextView{
    
    lazy var originalPassword = ""
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
  
    
    init(placeHolder:String,placeholderImage:UIImage) {
        super.init(frame: .zero, textContainer: nil)
        configure(placeHolder,placeholderImage)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(_ plaHolder:String,_ placeHolderImage:UIImage){
        
//        let attachment = NSTextAttachment()
//        attachment.image = placeHolderImage.withTintColor(.systemGray2)
//        attachment.bounds = CGRect(x: 0, y: -5, width: 23, height: 20)
//
//        let attachmentStr = NSAttributedString(attachment: attachment)
//        let myString = NSMutableAttributedString(string: "   ")
//        myString.append(attachmentStr)
//        let myString1 = NSMutableAttributedString(string:"  " + plaHolder,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)])
//        myString.append(myString1)
//
//        self.attributedPlaceholder = myString
        
        
        textAlignment = .left
        
        
        RoundCorners()
        AddStroke(color: .systemGray6)
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
   
    
    
    
}
