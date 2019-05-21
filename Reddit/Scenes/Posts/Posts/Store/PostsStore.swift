//
//  PostsStore.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


final class PostsStore: Store<PostsState> {

    // MARK: -
    // MARK: Properties

    /// The network reqeust store used to obtain
    private let requestStore: Store<NetworkRequestState<Page>> & NetworkRequestStoreCommands

    // MARK: -
    // MARK: Initialization

    init(requestStore: Store<NetworkRequestState<Page>> & NetworkRequestStoreCommands) {
        self.requestStore = requestStore

        super.init(state: PostsState(
            subreddit: nil,
            requestState: .idle))

        requestStore.onStateChanged = { [weak self] state in
            self?.stateChanged(to: state)
        }
    }
    
}


// MARK: -
// MARK: PostsStoreCommands

extension PostsStore: PostsStoreCommands {

    func updatePosts() {
        requestStore.execute(endpoint: endpoint(from: state))
    }

    func updateSubreddit(to category: String?) {
        if let category = category, category.isEmpty {
            return
        }

        state.subreddit = category
        requestStore.execute(endpoint: endpoint(from: state))
    }

}


// MARK: -
// MARK: State Changes

private extension PostsStore {

    func stateChanged(to requestState: NetworkRequestState<Page>) {
        state.requestState = requestState
    }

}


// MARK: -
// MARK: Pure Helpers

/// Maps the current domain state to the correct endpoint.
///
/// - Parameter state: The current domain state.
/// - Returns: The endpoint to use for fetching posts.
private func endpoint(from state: PostsState) -> Endpoint {
    if let subreddit = state.subreddit {
        return .subreddit(named: subreddit)
    } else {
        return .home
    }
}
