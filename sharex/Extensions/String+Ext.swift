//
//  String+Ext.swift
//  sharex
//
//  Created by Amr Moussa on 16/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//


import Foundation

extension String {

    var isValidEmail: Bool {
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }


    var isValidPassword: Bool {
        //Regex restricts to 8 character minimum, 1 capital letter, 1 lowercase letter, 1 number
        //If you have different requirements a google search for "password requirement regex" will help
        let passwordFormat      = "(?=.*[A-Za-z0-9]).{8,}"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }


    var isValidPhoneNumber: Bool {
       
        let phoneNumberFormat = "(?=.*^[0-9]).{10,20}"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return numberPredicate.evaluate(with: self)
    }
    
    // user name regex explaination.
    /* ^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._ ]+(?<![_.])$
         └─────┬────┘└───┬──┘└─────┬─────┘└─────┬─────┘ └───┬───┘
               │         │         │            │           no _ or . at the end
               │         │         │            │
               │         │         │            allowed characters including space 
               │         │         │
               │         │         no __ or _. or ._ or .. inside
               │         │
               │         no _ or . at the beginning
               │
               username is 8-20 characters long */
    
    var isValidUserName:Bool{
        let userNameFormat = "^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._ ]+(?<![_.])$"
        let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameFormat)
        return userNamePredicate.evaluate(with: self)
    }


    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
