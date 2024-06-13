//
// MainVMSection.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension MainViewModel {

    enum Section {
        case stocks([Product])
        case exclusives([Product])
        case news([Product])
        case hits([Product])
    }
}

// MARK: - Calculated Values

extension MainViewModel.Section: Identifiable {

    var id: Int {
        switch self {
        case .stocks:
            return 0
        case .exclusives:
            return 1
        case .news:
            return 2
        case .hits:
            return 3
        }
    }

    var title: String {
        switch self {
        case .stocks:
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
        case let .stocks(products):
            return products
        case let .exclusives(products):
            return products
        case let .news(products):
            return products
        case let .hits(products):
            return products
        }
    }
}

// MARK: - Mock Data

#if DEBUG
extension [MainViewModel.Section]: Mockable {

    static let mockData: [MainViewModel.Section] = [
        .stocks(stocksData),
        .exclusives(exclusivesData),
        .hits(hitsData),
        .news(newsData)
    ]

    private static let stocksData: [MainViewModel.Product] = (1...10).map {
        .init(
            id: $0,
            imageURL: "https://w.forfun.com/fetch/36/36c07e134d6b2fb0f8bdb312fafad549.jpeg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: ["Акция"]
        )
    }
    private static let exclusivesData: [MainViewModel.Product] = (11...20).map {
        .init(
            id: $0,
            imageURL: "https://w.forfun.com/fetch/1c/1c0cb4d2eb25fc8b9dbc607f1a00999c.jpeg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: ["Эксклюзив"]
        )
    }
    private static let hitsData: [MainViewModel.Product] = (21...30).map {
        .init(
            id: $0,
            imageURL: "https://i.pinimg.com/originals/0a/11/5c/0a115c7cc29faac76456247ae095d771.jpg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: ["Хит"]
        )
    }
    private static let newsData: [MainViewModel.Product] = (31...40).map {
        .init(
            id: $0,
            imageURL: "https://get.wallhere.com/photo/night-long-hair-anime-anime-girls-blue-eyes-open-mouth-looking-at-viewer-sky-Moon-blue-screenshot-mecha-computer-wallpaper-57041.jpg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: ["Новинки"]
        )
    }
}
#endif
