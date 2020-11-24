//
//  ProductCountLabel.swift
//  sharex
//
//  Created by Amr Moussa on 22/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class ProductCountLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        

        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure(){

            textColor = .label
            font = UIFont.systemFont(ofSize: 16, weight: .regular)
            numberOfLines = 1
            translatesAutoresizingMaskIntoConstraints = false
        }
        
            
       

    }


