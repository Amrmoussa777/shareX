//
//  Message.swift
//  sharex
//
//  Created by Amr Moussa on 30/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import Foundation

struct Message:Equatable {
    var id:String
    let senderID:String
    let textBody:String
    let timeStamp:Double
}
