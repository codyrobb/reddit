//
//  Endpoints.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation
import Alamofire


enum Endpoint {

    /// Fetches posts from the home page of reddit.
    case home

    /// Fetches posts from the specific given subreddit.
    case subreddit(named: String)

}


// MARK: -
// MARK: Queries

extension Endpoint {

    /// The path for the specific endpoint.
    var path: String {
        switch self {
        case .home:
            return "/.json"
        case .subreddit(let subreddit):
            return "/r/" + subreddit + "/.json"
        }
    }

}


// MARK: -
// MARK: URLRequestConvertible

extension Endpoint: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        let base = "https://www.reddit.com"
        let baseWithPath = base + path
        let url = try baseWithPath.asURL()

        return URLRequest(url: url)
    }

}


// MARK: -
// MARK: Equatable

extension Endpoint: Equatable {

    static func ==(lhs: Endpoint, rhs: Endpoint) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        case (.subreddit(let lhsName), .subreddit(let rhsName)):
            return lhsName == rhsName
        default:
            return false
        }
    }

}
