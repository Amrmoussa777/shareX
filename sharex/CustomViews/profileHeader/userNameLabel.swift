//
//  userNameLabel.swift
//  sharex
//
//  Created by Amr Moussa on 01/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class UserNameLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
     func configure(){
        textColor = .label
        numberOfLines = 1
        font = UIFont.systemFont(ofSize: 15, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
        text = "username"
    }
    
    func setName(name:String){
        self.text = name.capitalized
    }
    
    
}


class ProfileUserName:UserNameLabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func configure() {
        super.configure()
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textAlignment = .center
    }
    
    
    
}
