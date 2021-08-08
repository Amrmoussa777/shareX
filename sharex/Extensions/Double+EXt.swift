//
//  Double+EXt.swift
//  sharex
//
//  Created by Amr Moussa on 08/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUnixTime() -> String {
//        tiem ago
        let str = Date(timeIntervalSince1970: self).timeAgoDisplay()
        return str
    }
    func getDateAndTimedFormated() ->String{
//        MMM d, h:mm a       _format 
        let str = Date(timeIntervalSince1970: self).getDateAndTime()
        return str
    }
}
