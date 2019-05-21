//
//  PostsViewModelDelegate.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


protocol PostsViewModelDelegate: class {

    /// Called when the user selects to update the subreddit of posts they are seeing.
    func didSelectUpdateSubreddit()

    /// Called when the user selected a post to navigate to.
    ///
    /// - Parameter post: The post that the user selected.
    func didSelectPost(_ post: Post)

}
