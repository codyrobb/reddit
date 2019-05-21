//
//  PostsStoreCommands.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


protocol PostsStoreCommands {
    
    /// Refreshes the list of posts.
    func updatePosts()

    /// Changes the category of the posts and refreshes the list.
    ///
    /// - Parameter subreddit: The subreddit to find posts from.
    func updateSubreddit(to subreddit: String?)

}
