//
//  DateLabel.swift
//  sharex
//
//  Created by Amr Moussa on 01/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class  DateLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func configure(){
        
        numberOfLines = 1
        font = UIFont.systemFont(ofSize: 10, weight:.medium)
        translatesAutoresizingMaskIntoConstraints = false
//        text = "date"
    }
    
    func setDate(date:String,alignment:NSTextAlignment = .center,textClr:UIColor = .lightGray ){
        textColor = textClr
        self.textAlignment = alignment
        self.text = date
    }
    
    override func setNeedsLayout() {
        RoundCorners()
    }
    
}
