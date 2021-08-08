//
//  BuyButton.swift
//  sharex
//
//  Created by Amr Moussa on 20/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ShareButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text:String,bGColor:UIColor,iconImage:UIImage? = Images.bagImage) {
        super.init(frame: .zero)
       
        setTitle(text.capitalized, for: .normal)
        
        
        backgroundColor   = bGColor
        
        configure(iconImage: iconImage)

    }
    
      private func configure(iconImage:UIImage?){
        
        let image = iconImage
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        imageView?.tintColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setCommentTitle(commentCount:Int){
        setTitle("Comment (\(commentCount))", for: .normal)
    }
    
    func configureAsJoined(enabled:Bool){
        isEnabled = enabled
        backgroundColor = .blue
        setTitle("Joined", for: .normal)
        setImage(Images.bagImage, for: .normal)
    }
}


class LogOutButton:ShareButton{
    
    override init(text: String, bGColor: UIColor, iconImage: UIImage? = Images.bagImage) {
        super.init(text: text, bGColor: bGColor, iconImage: iconImage)
        configureAsLogOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureAsLogOut(){
        backgroundColor = .clear
        AddStroke(color: .systemOrange)
        setTitleColor(.systemOrange, for: .normal)
        titleLabel?.tintColor = .systemOrange
    }
    
    
    
    
    
}
