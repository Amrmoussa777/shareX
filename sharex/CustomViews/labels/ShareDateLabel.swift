//
//  ShareDateLabel.swift
//  sharex
//
//  Created by Amr Moussa on 30/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class ShareDateLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        textColor = .lightGray
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setDate(userName:String,timaStamp:Double){
        text = userName + ", " + timaStamp.getDateAndTimedFormated()
    }
    
}



