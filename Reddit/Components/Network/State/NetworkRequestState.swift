//
//  NetworkRequestState.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


enum NetworkRequestState<T: Decodable & Equatable>: State {

    /// The store is yet to do any operation.
    case idle

    /// The network request is loading.
    case loading

    /// The network request successfully loaded and decoded results.
    case success(T)

    /// The network request failed and returned an error.
    case failure(NetworkError)

}


// MARK: -
// MARK: Queries

extension NetworkRequestState {

    /// Determines whether or not the state is currently loading.
    var isLoading: Bool {
        return self == .loading
    }

    /// Obtains the error if possible; nil otherwise.
    var error: NetworkError? {
        guard case .failure(let error) = self else {
            return nil
        }

        return error
    }

    /// Obtains the results if possible; nil otherwise.
    var results: T? {
        guard case .success(let results) = self else {
            return nil
        }

        return results
    }

}


// MARK: -
// MARK: Equatable

extension NetworkRequestState: Equatable {

    static func ==(lhs: NetworkRequestState, rhs: NetworkRequestState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return lhs.results == rhs.results
        case (.failure, .failure):
            return lhs.error == rhs.error
        default:
            return false
        }
    }

}
