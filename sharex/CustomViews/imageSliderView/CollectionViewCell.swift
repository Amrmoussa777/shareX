//
//  CollectionViewCell.swift
//  sharex
//
//  Created by Amr Moussa on 02/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {
    
    
    static let cellID = "imageSliderCellID"
    let imageView = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .orange
        addSubview(imageView)
        imageView.pinToSuperViewEdges(in:self)
    }
    
    func setImage(img:UIImage){
        DispatchQueue.main.async {
            // You should here calling network manager for retrieving image from server .
            self.imageView.image = img

        }
    }
    
    
}
