//
//  PostsCoordinator.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


final class PostsCoordinator {

    // MARK: -
    // MARK: Properties

    /// The main window.
    private weak var window: UIWindow?

    /// The root navigation controller.
    private weak var navigationController: UINavigationController?

    /// The store for the posts scene.
    private weak var postsStore: (Store<PostsState> & PostsStoreCommands)?

    // MARK: -
    // MARK: Initialization

    /// Initializes the AppCoordinator with the main window.
    ///
    /// - Parameter window: The main window.
    init(window: UIWindow?) {
        self.window = window
    }

    // MARK: -
    // MARK: Methods

    /// Load initial scene into view.
    func launch() {
        let storyboard = UIStoryboard(name: "Posts", bundle: Bundle(for: PostsViewController.self))
        let store = PostsStore(requestStore: NetworkRequestStore<Page>())
        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nc.viewControllers.first as! PostsViewController

        vc.viewModel = PostsViewModel(store: store, delegate: self)

        window?.rootViewController = nc
        navigationController = nc
        postsStore = store
    }

}


// MARK: -
// MARK: PostsViewModelDelegate

extension PostsCoordinator: PostsViewModelDelegate {

    func didSelectUpdateSubreddit() {
        /// This would be an ideal spot to kick off another scene/coordinator, but feels overkill for
        /// this example app.
        let alertController = UIAlertController(
            title: "Switch Feeds?",
            message: nil,
            preferredStyle: .alert)

        alertController.addTextField { field in
            field.placeholder = "spacex"
        }

        alertController.addAction(UIAlertAction(title: "Switch", style: .default, handler: { [weak self] _ in
            self?.postsStore?.updateSubreddit(to: alertController.textFields?.first?.text)
        }))

        alertController.addAction(UIAlertAction(title: "Home", style: .default, handler: { [weak self] _ in
            self?.postsStore?.updateSubreddit(to: nil)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        navigationController?.present(alertController, animated: true)
    }

    func didSelectPost(_ post: Post) {
        /// This would be an ideal spot to kick off another scene/coordinator, but feels overkill for
        /// this example app.
        navigationController?.present(SFSafariViewController(url: post.url), animated: true)
    }

}
