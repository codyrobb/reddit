//
//  PostItemViewModel.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


final class PostItemViewModel: PostItemViewModelProtocol {

    // MARK: -
    // MARK: Properties

    /// The post powering the cell.
    let post: Post

    /// The state to render in the cell.
    let state: PostItemState

    // MARK: -
    // MARK: Initialization

    init(post: Post) {
        self.post = post
        self.state = PostItemState(
            title: post.title,
            subreddit: post.subreddit)
    }
    
}
