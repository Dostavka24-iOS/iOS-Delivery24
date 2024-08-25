//
// ScreenState.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

enum ScreenState: Identifiable {
    case initial
    case loading
    case alert(APIError)
    case `default`
}

extension ScreenState {

    var id: String {
        switch self {
        case .initial: "initial"
        case .loading: "loading"
        case .alert: "alert"
        case .default: "default"
        }
    }

    static func == (lhs: ScreenState, rhs: ScreenState) -> Bool {
        lhs.id == rhs.id
    }
}
