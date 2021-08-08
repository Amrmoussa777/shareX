//
//  CreateNewProductCVcell.swift
//  sharex
//
//  Created by Amr Moussa on 01/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//


import UIKit

class CreateNewProductCVcell: UICollectionViewCell {
    
    static let cellID = "NewProductCVcell"
    
    let infoLabel = ProductItemLable(textAlignment: .center, NoOfLines: 0, size: 15)
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(view:UIView,constrains:NSLayoutConstraint) {
        super.init(frame: .zero)
        //configure(view, constrains: constrains)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func configure(){
        contentView.backgroundColor = .systemBackground
        
        RoundCorners()
        
        contentView.addSubViews(infoLabel)
        
        infoLabel.textColor = .tertiaryLabel
        
        NSLayoutConstraint.activate([
      
            
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -60),
            infoLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 50),
        
        ])
        
       // registerLabel2.text = "Cell sign up" + String(self.tag)
        
        
    }
    func addContentViews(_ views:[UIView],constrains:[NSLayoutConstraint],topMessage:String){
        
        infoLabel.text = topMessage
        
        for view in views {
            contentView.addSubview(view)
            contentView.bringSubviewToFront(view)
            view.translatesAutoresizingMaskIntoConstraints  = false
        }
        
        NSLayoutConstraint.activate(constrains)
        layoutIfNeeded()
    }
    
    
}
