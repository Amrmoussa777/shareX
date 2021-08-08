//
//  EmptyStateView.swift
//  sharex
//
//  Created by Amr Moussa on 04/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class EmptyStateView: UIView {
    
    let imgView = AvatarImageView()
    let label = ProductItemLable(textAlignment: .center, NoOfLines: 4, size: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(img:UIImage,message:String) {
        self.init(frame:.zero)
        setState(image: img, message: message)
    }
    
    
    private func configure(){
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(imgView,label)
        
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            imgView.widthAnchor.constraint(equalToConstant: 200),
            imgView.heightAnchor.constraint(equalToConstant: 200),
            
            label.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -10),
            label.widthAnchor.constraint(equalTo: widthAnchor,constant: -10),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    private func configureLabel(){
        label.textColor = .tertiaryLabel
    }
    
    func setState(image:UIImage,message:String){
        DispatchQueue.main.async {
            self.imgView.setImage(image: image)
            self.label.text = message
        }
        
        
    }
    
    
}
