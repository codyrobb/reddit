//
//  NetworkRequestStore.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation
import Alamofire


final class NetworkRequestStore<T: Decodable & Equatable>: Store<NetworkRequestState<T>> {

    // MARK: -
    // MARK: Properties

    /// The latest request that was executed.
    private var request: DataRequest?

    // MARK: -
    // MARK: Initialization

    /// Initializes a new NetworkRequestStore in the default state.
    init() {
        super.init(state: .idle)
    }

}


// MARK: -
// MARK: Commands

extension NetworkRequestStore: NetworkRequestStoreCommands {

    func execute(endpoint: Endpoint) {
        state = .loading

        request?.cancel()
        request = AF.request(endpoint).responseDecodable { [weak self] (response: DataResponse<T>) in
            guard let self = self else { return }

            switch response.result {
            case .success(let page):
                self.state = .success(page)
            case .failure(let error):
                if let error = error as? AFError {
                    switch error {
                    case .invalidURL:
                        self.state = .failure(.invalidURL)
                    case .responseSerializationFailed:
                        self.state = .failure(.invalidResponse)
                    default:
                        self.state = .failure(.unknownError(error))
                    }
                } else {
                    self.state = .failure(.unknownError(error))
                }
            }
        }
    }

}
