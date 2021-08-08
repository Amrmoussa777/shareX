//
//  UIimageView+Ext.swift
//  sharex
//
//  Created by Amr Moussa on 02/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(fromURL url: String) {
         NetworkManager.Shared.downloadImage(from: url) { [weak self] (image) in
         guard let self = self else { return }
         DispatchQueue.main.async {
            self.image = image
            self.contentMode = .scaleAspectFill
         }
            
     }
       
    }
}
    

