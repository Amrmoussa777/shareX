//
//  SendButton.swift
//  sharex
//
//  Created by Amr Moussa on 22/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//



import UIKit

class SendButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(bGColor:UIColor,iconImage:UIImage? = Images.bagImage) {
        super.init(frame: .zero)
        backgroundColor   = bGColor
        
        configure(iconImage: iconImage)

    }
    
    private  func configure(iconImage:UIImage?){
        
        let image = iconImage
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageView?.tintColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
