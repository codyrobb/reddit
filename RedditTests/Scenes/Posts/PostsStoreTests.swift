//
//  PostsStoreTests.swift
//  RedditTests
//
//  Created by Cody Robertson on 5/21/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import XCTest
@testable import Reddit


class PostsStoreTests: XCTestCase {

    // MARK: -
    // MARK: Lifecycle

    override func setUp() {
    }

    override func tearDown() {
    }

    // MARK: -
    // MARK: Tests

    func testUpdateSubredditWithValidSubreddit() {
        let mock = MockNetworkStore(state: .idle)
        let store = PostsStore(requestStore: mock)
        let expect = expectation(description: "The subreddit will change to spacex")

        store.onStateChanged = { state in
            if state.subreddit == "spacex" { expect.fulfill() }
        }

        store.updateSubreddit(to: "spacex")

        waitForExpectations(timeout: 3.0)
    }

    func testUpdateSubredditWithInvalidSubreddit() {
        let mock = MockNetworkStore(state: .idle)
        let store = PostsStore(requestStore: mock)
        let expect = expectation(description: "The subreddit will not change to an empty string.")

        expect.isInverted = true

        store.onStateChanged = { state in
            if state.subreddit == "" { expect.fulfill() }
        }

        store.updateSubreddit(to: "spacex")
        store.updateSubreddit(to: "")

        waitForExpectations(timeout: 3.0)
    }

    func testCorrectEndpointHitWithSubreddit() {
        let mock = MockNetworkStore(state: .idle)
        let store = PostsStore(requestStore: mock)
        let expect = expectation(description: "The .subreddit(named: \"spacex\") endpoint will be hit")

        store.onStateChanged = { state in
            guard case .success = state.requestState else { return }

            if mock.previousEndpoint == .subreddit(named: "spacex") {
                expect.fulfill()
            }
        }

        store.updateSubreddit(to: "spacex")

        waitForExpectations(timeout: 3.0)
    }

    func testCorrectEndpointHitWithoutSubreddit() {
        let mock = MockNetworkStore(state: .idle)
        let store = PostsStore(requestStore: mock)
        let expect = expectation(description: "The .subreddit(named: \"spacex\") endpoint will be hit")

        store.onStateChanged = { state in
            guard case .success = state.requestState else { return }

            if mock.previousEndpoint == .home {
                expect.fulfill()
            }
        }

        store.updateSubreddit(to: nil)

        waitForExpectations(timeout: 3.0)
    }

}


// MARK: -
// MARK: Tools

private class MockNetworkStore: Store<NetworkRequestState<Page>>, NetworkRequestStoreCommands {

    // MARK: -
    // MARK: Properties

    var previousEndpoint: Endpoint? = nil

    // MARK: -

    func execute(endpoint: Endpoint) {
        previousEndpoint = endpoint
        state = .loading
        state = .success(Page(posts: []))
    }




}

