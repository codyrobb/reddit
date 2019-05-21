//
//  PostsViewState.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


struct PostsViewState: State {

    /// The title for the scene.
    let title: String

    /// The latest list of posts to render.
    let posts: [Post]

    /// True if the request is loading; false otherwise.
    let isLoading: Bool
    
}
