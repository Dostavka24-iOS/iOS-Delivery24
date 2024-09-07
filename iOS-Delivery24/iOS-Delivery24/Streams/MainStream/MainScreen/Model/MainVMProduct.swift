//
// MainVMProduct.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension MainViewModel {

    struct Product: Identifiable {
        let id           : Int
        let imageURL     : String
        let title        : String
        let price        : String
        let description  : String
        let startCounter : Int
        let magnifier    : Int
        let tags         : [Tags]
    }
}

// MARK: - Mock Data

#if DEBUG
extension MainViewModel.Product: Mockable {

    static let mockData = getMockEntity(id: 0)

    static func getMockEntity(id: Int) -> Self {
        MainViewModel.Product(
            id: id,
            imageURL: "https://w.forfun.com/fetch/36/36c07e134d6b2fb0f8bdb312fafad549.jpeg",
            title: "Моковый товар",
            price: "100.43₽",
            description: "Здесь будет моковое описание товара",
            startCounter: 0,
            magnifier: 1,
            tags: [.promotion, .exclusive]
        )
    }
}
#endif
