//
//  UIImage+EXT.swift
//  sharex
//
//  Created by Amr Moussa on 09/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


extension UIImage {
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
    var compressedImage:UIImage{
        guard let comppressedImage =  self.jpegData(compressionQuality: CGFloat(0.01)) else {
            print(self.description)
            return self
        }
        print("image compressed")
        print(comppressedImage.description)
        print(self.size)
        return UIImage(data: comppressedImage)!
    }


}
