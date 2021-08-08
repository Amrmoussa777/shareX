//
//  ShareCell.swift
//  sharex
//
//  Created by Amr Moussa on 09/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class ShareCell:UICollectionViewCell{
    static let cellID = "ShareCellID"
    
    let userhead = CellHeader()
    
    var user:User!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(userhead)
        
        backgroundColor = .systemBackground
        userhead.pinToSuperViewEdges(in: self)
        
    }
    
    
    func setUser(user:User){
        self.user = user
        self.userhead.set(avatarUrl: user.avatarUrl, username: user.userName, rating: user.userRating, date: 0)
        self.userhead.dateLabel.text = "☑️"
    }
    
}

