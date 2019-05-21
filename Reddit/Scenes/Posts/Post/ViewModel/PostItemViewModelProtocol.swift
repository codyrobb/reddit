//
//  PostItemViewModelProtocol.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


protocol PostItemViewModelProtocol {

    /// The state to render in the cell.
    var state: PostItemState { get }

}
