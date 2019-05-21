//
//  AppCoordinator.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation
import UIKit


final class AppCoordinator {

    // MARK: -
    // MARK: Properties

    /// The main window.
    private weak var window: UIWindow?

    // MARK: -
    // MARK: Child Coordinators

    /// The posts coordinator.
    private var postsCoordinator: PostsCoordinator?

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
        postsCoordinator = PostsCoordinator(window: window)
        postsCoordinator?.launch()
    }

}
