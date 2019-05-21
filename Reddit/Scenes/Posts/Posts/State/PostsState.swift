//
//  PostsState.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


struct PostsState: State {

    /// The name of the subreddit being view; nil otherwise.
    var subreddit: String?

    /// The current state of the posts request.
    var requestState: NetworkRequestState<Page>
    
}
