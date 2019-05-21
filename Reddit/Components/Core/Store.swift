//
//  Store.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


class Store<StateType: State> {

    // MARK: -
    // MARK: Properties

    /// The current state.
    var state: StateType {
        didSet { stateChanged(oldState: oldValue, newState: state) }
    }

    /// Closure that gets called when the state changes.
    var onStateChanged: ((StateType) -> ())?

    // MARK: -
    // MARK: Initialization

    /// Initializes a new Store with the given state as the initial state.
    ///
    /// - Parameter state: The initial state.
    init(state: StateType) {
        self.state = state
    }

}


// MARK: -
// MARK: Private

private extension Store {

    /// Determines if the state has changed and publishes the change
    /// to the "subscription" closure if so.
    ///
    /// - Parameters:
    ///     - oldState: The old state.
    ///     - newState: The new state.
    func stateChanged(oldState: StateType, newState: StateType) {
        guard oldState != newState else { return }

        DispatchQueue.main.async { [weak self] in
            self?.onStateChanged?(newState)
        }
    }

}
