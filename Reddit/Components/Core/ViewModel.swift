//
//  ViewModel.swift
//  Reddit
//
//  Created by Cody Robertson on 5/20/19.
//  Copyright © 2019 Cody Robertson. All rights reserved.
//

import Foundation


/// A marker protocol just to define a view model as it's own type.
typealias ViewModel<StateType: State> = Store<StateType>
