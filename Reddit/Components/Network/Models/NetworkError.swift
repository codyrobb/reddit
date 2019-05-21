//
//  NetworkError.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


enum NetworkError: Error {

    /// The URL was invalid.
    case invalidURL

    /// The response was invalid and JSON parsing failed.
    case invalidResponse

    /// An error occurred but the exact reason is unknown or unvaluable.
    case unknownError(Error)

}


// MARK: -
// MARK: Equatable

extension NetworkError: Equatable {

    static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.unknownError, .unknownError):
            return true
        default:
            return false
        }
    }

}
