//
//  Constants.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

enum TabbarImages{
    static let homeTabbarItemImage = UIImage(systemName: "house")
    static let groupTabbarItemImage = UIImage(systemName: "person.3")
    static let chatTabbarItemImage = UIImage(systemName: "message")
    static let profileTabbarItemImage = UIImage(systemName: "person")

}
enum Images {
    static let productImgPlaceholder = UIImage(named: "productImageIphone-2")
    static let notFavImage =  UIImage(systemName: "heart")
    static let FavImage =  UIImage(systemName: "heart.fill")
    static let bagImage = UIImage(systemName: "bag")
    static let commCountImage = UIImage(systemName: "person.2")
    static let soldcountImage = UIImage(systemName: "cart")

}

enum ProdcutCardTypes{
    case communityCount
    case soldCount
}
