//
//  PostsViewModelProtocol.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


protocol PostsViewModelProtocol {

    /// Changes the subreddit of the posts and refreshes the list.
    func updateSubreddit()

    /// Refreshes the list of posts.
    func updatePosts()

    /// Called when the user selects and individual post to view.
    ///
    /// - Parameter post: The post that was selected.
    func selectPost(_ post: Post)

}
