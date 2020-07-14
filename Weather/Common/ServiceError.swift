//
//  ServiceError.swift
//  Weather
//
//  Created by Kudzaiishe Mhou on 2020/07/07.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case requestFailed(error: Error)
    case decodeError
    case networkError
    
    var message: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The provided URL is not valid",
                                     comment: "Invalid URL")
        case .requestFailed(let error):
            return NSLocalizedString("The request has failed to complete. Please try again",
                                     comment: error.localizedDescription)
        case .decodeError:
            return NSLocalizedString("Decoding error",
                                     comment: "Request failed")
        case .networkError:
            return NSLocalizedString("No Network error",
                                     comment: "Request failed")
        }
    }
}

