//
//  PostsViewModel.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


final class PostsViewModel: ViewModel<PostsViewState> {

    // MARK: -
    // MARK: Properties

    /// The delegate to notify when certain events happen.
    private weak var delegate: PostsViewModelDelegate?

    /// The store for the posts scene.
    private let store: Store<PostsState> & PostsStoreCommands

    // MARK: -
    // MARK: Initialization

    /// Initializes a new `PostsViewModel` with the given store and delegate and subscribes to the
    /// store for state changes.
    ///
    /// - Parameters:
    ///     - store: The store for the posts scene.
    ///     - delegate: The delegate to notify when certain events happen.
    init(store: Store<PostsState> & PostsStoreCommands, delegate: PostsViewModelDelegate?) {
        self.delegate = delegate
        self.store = store

        super.init(state: PostsViewState(
            title: "Home",
            posts: [],
            isLoading: false))

        store.onStateChanged = { [weak self] state in
            self?.stateChanged(to: state)
        }
    }

}


// MARK: -
// MARK: PostsViewModelProtocol

extension PostsViewModel: PostsViewModelProtocol {

    func updateSubreddit() {
        delegate?.didSelectUpdateSubreddit()
    }

    func updatePosts() {
        store.updatePosts()
    }

    func selectPost(_ post: Post) {
        delegate?.didSelectPost(post)
    }

}


// MARK: -
// MARK: State Changes

private extension PostsViewModel {

    /// Called when the state changes. This is the correct time to map the latest domain state to
    /// a new view state.
    ///
    /// - Parameter state: The latest domain state.
    func stateChanged(to domainState: PostsState) {
        state = PostsViewState(
            title: mapStateToTitle(state: domainState),
            posts: mapStateToPosts(state: domainState),
            isLoading: domainState.requestState.isLoading)
    }

}


// MARK: -
// MARK: Pure Helpers

/// Maps the latest domain state to the correct title for the view.
///
/// - Parameter state: The latest domain state.
/// - Returns: The title for the view.
private func mapStateToTitle(state: PostsState) -> String {
    if let subreddit = state.subreddit {
        return subreddit
    } else {
        return "Home"
    }
}

/// Maps the latest domain state to the latest list of posts.
///
/// - Parameter state: The latest domain state.
/// - Returns: The list of posts.
private func mapStateToPosts(state: PostsState) -> [Post] {
    return state.requestState.results?.posts ?? []
}
