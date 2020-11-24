//
//  LayoutBuilder.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

struct LayoutBuilder {
    
    static func createColumnsFlowLayout(in view:UIView,columns:CGFloat) -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding:CGFloat = 10
        let innerSpacing:CGFloat  = 10 * (columns-1)
        let availableWidth = width - (padding * 2) - innerSpacing
        let itemWidth = availableWidth / columns
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 2)
        
        return flowLayout
    }
}
