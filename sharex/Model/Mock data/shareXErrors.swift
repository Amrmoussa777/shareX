//
//  shareXErrors.swift
//  sharex
//
//  Created by Amr Moussa on 06/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import Foundation


enum  networkError:String,Error {
    case noInternetConnection = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this product. Please try again."
    case unableToComment = "there was an error saving your comment please try again."
}

