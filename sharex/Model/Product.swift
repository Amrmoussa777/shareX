//
//  Product.swift
//  sharex
//
//  Created by Amr Moussa on 19/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import Foundation

struct Product:Codable,Hashable{
    let name:String
    var imageUrl:String
    let price:Double
}
