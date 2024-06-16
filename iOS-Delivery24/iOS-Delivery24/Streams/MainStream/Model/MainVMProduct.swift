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
        let id          : Int
        let imageURL    : String
        let title       : String
        let price       : String
        let description : String
        let tags        : [String]
    }
}

// MARK: - Mock Data

#if DEBUG
extension MainViewModel.Product: Mockable {

    static let mockData = MainViewModel.Product(
        id: 0,
        imageURL: "https://w.forfun.com/fetch/36/36c07e134d6b2fb0f8bdb312fafad549.jpeg",
        title: "Моковый товар",
        price: "100.43₽",
        description: "Здесь будет моковое описание товара",
        tags: ["Акции", "Эксклюзив"]
    )
}
#endif
