//
//  HTTPNetworkError.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import Foundation

enum HTTPNetworkError: Error {
    case unableToDecode
    case noInternetConnection
    case other
   
    var errorMessage: String {
        switch  self {
        case .noInternetConnection:
            return  "The Internet connection appears to be offline."
        default:
            return "Something went wrong! Please try again!"
        }
    }
}
