//
// MainVMUIProperties.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI

extension MainViewModel {

    struct UIProperties {
        var searchText = ""
        var size: CGSize = .zero
        var lastSelectedSection: String?
        var screenState = ScreenState.initial
    }
}

extension MainViewModel.UIProperties {

    enum ScreenState: Identifiable {
        case initial
        case loading
        case alert(APIError)
        case `default`
    }
}

extension MainViewModel.UIProperties.ScreenState {

    var id: String {
        switch self {
        case .initial: "initial"
        case .loading: "loading"
        case .alert: "alert"
        case .default: "default"
        }
    }

    static func == (lhs: MainViewModel.UIProperties.ScreenState, rhs: MainViewModel.UIProperties.ScreenState) -> Bool {
        lhs.id == rhs.id
    }
}
