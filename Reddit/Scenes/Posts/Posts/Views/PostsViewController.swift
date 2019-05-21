//
//  PostsViewController.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation
import UIKit


final class PostsViewController: UITableViewController {

    // MARK: -
    // MARK: Properties

    /// The view model for the posts scene.
    var viewModel: (ViewModel<PostsViewState> & PostsViewModelProtocol)?

    /// The posts to be rendered.
    var posts = [Post]() {
        didSet { tableView.reloadData() }
    }

    // MARK: -
    // MARK: IBOutlets

    @IBOutlet weak var switcherButton: UIBarButtonItem?

    // MARK: -
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        viewModel?.updatePosts()
        viewModel?.onStateChanged = { [weak self] state in
            self?.render(state: state)
        }
    }

    // MARK: -
    // MARK: Actions

    @IBAction func changeCategory(_ sender: Any) {
        viewModel?.updateSubreddit()
    }

    @IBAction func refreshPosts() {
        viewModel?.updatePosts()
    }

}


// MARK: -
// MARK: UITableViewDataSource

extension PostsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as! PostCell
        cell.viewModel = PostItemViewModel(post: posts[indexPath.row])
        return cell
    }

}


// MARK: -
// MARK: UITableViewDelegate

extension PostsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectPost(posts[indexPath.row])
    }

}


// MARK: -
// MARK: View Setup

private extension PostsViewController {

    func setupView() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
    }

}


// MARK: -
// MARK: State Changes

private extension PostsViewController {

    func render(state: PostsViewState) {
        posts = state.posts
        switcherButton?.title = state.title

        if state.isLoading {
            refreshControl?.beginRefreshing()
        } else {
            refreshControl?.endRefreshing()
        }
    }

}
