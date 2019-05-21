//
//  NetworkRequestStoreCommands.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


protocol NetworkRequestStoreCommands {

    /// Executes the network request for the given endpoint.
    ///
    /// - Parameter endpoint: The endpoint to execute a network request for.
    func execute(endpoint: Endpoint)

}
