//
//  CreateNewSharingView.swift
//  sharex
//
//  Created by Amr Moussa on 01/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class CreateNewSharingView: UIView {
    
    let createSharing = ShareButton(text: "Create New SHaring", bGColor: .orange, iconImage: Images.commInfoImage!)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(createSharing)
        backgroundColor = .systemGray6
        RoundCorners()
        let padding:CGFloat = 10
        createSharing.pinToSuperViewEdgesWithPadding(in: self, padding: padding)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    
}
