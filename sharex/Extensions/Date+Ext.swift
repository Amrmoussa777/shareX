//
//  Date+Ext.swift
//  sharex
//
//  Created by Amr Moussa on 08/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import Foundation


extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func getDateAndTime() ->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let res = formatter.string(from: self)
        return res
    }
    
}
