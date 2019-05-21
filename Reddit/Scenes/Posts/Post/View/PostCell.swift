//
//  PostCell.swift
//  Reddit
//
//  Created by Cody Robertson on 5/21/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation
import UIKit


final class PostCell: UITableViewCell {

    // MARK: -
    // MARK: Static

    static let reuseIdentifier = "PostCell"

    // MARK: -
    // MARK: Properties

    /// The view model powering the cell.
    var viewModel: PostItemViewModelProtocol? {
        didSet {
            titleLabel?.text = viewModel?.state.title
            subredditLabel?.text = viewModel?.state.subreddit
        }
    }

    // MARK: -
    // MARK: IBOutlets

    @IBOutlet weak var titleLabel: UILabel?

    @IBOutlet weak var subredditLabel: UILabel?

}
