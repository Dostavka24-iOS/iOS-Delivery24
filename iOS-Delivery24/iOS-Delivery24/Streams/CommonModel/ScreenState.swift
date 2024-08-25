//
// ScreenState.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

enum ScreenState {
    case initial
    case error(APIError)
    case loading
    case `default`
}

extension ScreenState {

    var id: String {
        switch self {
        case .initial: "initial"
        case .loading: "loading"
        case .error: "alert"
        case .default: "default"
        }
    }

    static func == (lhs: ScreenState, rhs: ScreenState) -> Bool {
        lhs.id == rhs.id
    }
}
