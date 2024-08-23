//
// MainVMSection.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension MainViewModel {

    enum Section: Identifiable, CaseIterable {
        case actions([ProductEntity])
        case exclusives([ProductEntity])
        case news([ProductEntity])
        case hits([ProductEntity])
    }
}

// MARK: - Calculated Values

extension MainViewModel.Section {

    var id: Int {
        switch self {
        case .actions:
            return 0
        case .exclusives:
            return 1
        case .news:
            return 2
        case .hits:
            return 3
        }
    }

    static var allCases: [MainViewModel.Section] = [
        .actions([]), .exclusives([]), .news([]), .hits([])
    ]

    var title: String {
        switch self {
        case .actions:
            return String(localized: "stocks")
        case .exclusives:
            return String(localized: "exclusives")
        case .news:
            return String(localized: "news")
        case .hits:
            return String(localized: "hits")
        }
    }

    var products: [MainViewModel.Product] {
        switch self {
        case let .actions(products):
            return products.compactMap(\.mapper)
        case let .exclusives(products):
            return products.compactMap(\.mapper)
        case let .news(products):
            return products.compactMap(\.mapper)
        case let .hits(products):
            return products.compactMap(\.mapper)
        }
    }
}
