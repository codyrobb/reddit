//
//  PostsViewModelTests.swift
//  RedditTests
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import XCTest
@testable import Reddit


class PostsViewModelTests: XCTestCase {

    // MARK: -
    // MARK: Lifecycle

    override func setUp() {
    }

    override func tearDown() {
    }

    // MARK: -
    // MARK: Tests

    func testExecutingRequestTriggersIsLoadingThenStops() {
        let delegate = MockPostsViewModelDelegate()
        let store = MockPostsStore()
        let vm = PostsViewModel(store: store, delegate: delegate)

        let expect1 = expectation(description: "isLoading will become true.")
        let expect2 = expectation(description: "isLoading will become false _after_ it was true.")

        vm.onStateChanged = { state in
            if state.isLoading {
                expect1.fulfill()
            } else {
                expect2.fulfill()
            }
        }

        store.updatePosts()

        waitForExpectations(timeout: 3.0)
    }

    func testMapsToCorrectTitleWithSubreddit() {
        let delegate = MockPostsViewModelDelegate()
        let store = MockPostsStore()
        let vm = PostsViewModel(store: store, delegate: delegate)

        let expect = expectation(description: "The title will become spacex")

        vm.onStateChanged = { state in
            if state.title == "spacex" { expect.fulfill() }
        }

        store.state.subreddit = "spacex"

        waitForExpectations(timeout: 3.0)
    }

    func testMapsToCorrectTitleWithoutSubreddit() {
        let delegate = MockPostsViewModelDelegate()
        let store = MockPostsStore(subreddit: nil)
        let vm = PostsViewModel(store: store, delegate: delegate)

        XCTAssertEqual(vm.state.title, "Home")
    }

    func testDelegateCalledWhenSelectingPost() {
        let delegate = MockPostsViewModelDelegate()
        let store = MockPostsStore()
        let vm = PostsViewModel(store: store, delegate: delegate)

        let post = Post(title: "This is my title", subreddit: "mysubreddit", url: URL(string: "https://reddit.com")!)

        vm.selectPost(post)

        XCTAssert(delegate.hasCalledSelectPost)
    }

    func testDelegateCalledWhenUpdatingCategory() {
        let delegate = MockPostsViewModelDelegate()
        let store = MockPostsStore()
        let vm = PostsViewModel(store: store, delegate: delegate)

        vm.updateSubreddit()

        XCTAssert(delegate.hasCalledSelectUpdateCategory)
    }

}


// MARK: -
// MARK: Tools

private class MockPostsStore: Store<PostsState>, PostsStoreCommands {

    init(subreddit: String? = nil, requestState: NetworkRequestState<Page> = .idle) {
        super.init(state: PostsState(
            subreddit: subreddit,
            requestState: requestState))
    }

    func updatePosts() {
        state.requestState = .loading
        state.requestState = .success(Page(posts: []))
    }

    func updateSubreddit(to category: String?) {
        state.subreddit = category
        state.requestState = .loading
        state.requestState = .success(Page(posts: []))
    }

}


private class MockPostsViewModelDelegate: PostsViewModelDelegate {

    var hasCalledSelectUpdateCategory = false

    var hasCalledSelectPost = false

    func didSelectUpdateSubreddit() {
        hasCalledSelectUpdateCategory = true
    }

    func didSelectPost(_ post: Post) {
        hasCalledSelectPost = true
    }



}
