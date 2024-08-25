//
// MainVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension MainViewModel: Mockable {

    static let mockData: MainViewModel = MainViewModel(data: .init(sections: .mockData))
}

extension [MainViewModel.Section]: Mockable {

    static let mockData: [MainViewModel.Section] = [
        .actions(stocksData.map(\.mapperToEntity)),
        .exclusives(exclusivesData.map(\.mapperToEntity)),
        .hits(hitsData.map(\.mapperToEntity)),
        .news(newsData.map(\.mapperToEntity))
    ]

    static let fakeEntityProducts: [ProductEntity] = [MainViewModel.Section].mockData.last?.products.map(\.mapperToEntity) ?? []

    private static let stocksData: [MainViewModel.Product] = (1...10).map {
        .init(
            id: $0,
            imageURL: URL?.mockURL?.absoluteString ?? "",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: [.promotion]
        )
    }
    private static let exclusivesData: [MainViewModel.Product] = (11...20).map {
        .init(
            id: $0,
            imageURL: "https://w.forfun.com/fetch/1c/1c0cb4d2eb25fc8b9dbc607f1a00999c.jpeg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: [.exclusive]
        )
    }
    private static let hitsData: [MainViewModel.Product] = (21...30).map {
        .init(
            id: $0,
            imageURL: "https://i.pinimg.com/originals/0a/11/5c/0a115c7cc29faac76456247ae095d771.jpg",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: [.hit]
        )
    }
    static let newsData: [MainViewModel.Product] = (31...40).map {
        .init(
            id: $0,
            imageURL: "/import/import_files/4e/4efb83e35bd811ef8d5f005056845ec0_4efb83f05bd811ef8d5f005056845ec0.png",
            title: "Моковый товар #\($0)",
            price: "\($0)₽",
            description: "Описание мока #\($0)",
            tags: [.news]
        )
    }
}

private extension MainViewModel.Product {

    var mapperToEntity: ProductEntity {
        .init(
            id: id,
            sku: nil,
            title: title,
            price: nil,
            quantity: nil,
            description: description,
            image: imageURL,
            categoryID: nil,
            priceSale: nil,
            cashback: nil,
            brandID: nil,
            manufacturerID: nil,
            createdAt: nil,
            updatedAt: nil,
            slug: nil,
            actionFlag: nil,
            actionCountdown: nil,
            coeff: nil,
            ean: nil,
            hit: tags.contains(.hit) ? 1 : 0,
            actionFlag2: tags.contains(.promotion) ? 1 : 0,
            exclusFlag: tags.contains(.promotion) ? 1 : 0,
            rating: nil,
            priceItem: price,
            tags: nil,
            maxInOrder: nil,
            expirationDate: nil,
            kolvoUpak: nil,
            newYearFlag: nil,
            quantity2: nil,
            countryID: nil,
            brandTitle: nil,
            whishlistFlag: nil,
            brand: .init(id: nil, title: nil, createdAt: nil, updatedAt: nil, mainFlag: nil)
        )
    }
}
#endif
