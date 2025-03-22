//
//  ViewState.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/22/25.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case loaded
    case partialLoaded(message: String)
    case empty
    case error(message: String)
}
