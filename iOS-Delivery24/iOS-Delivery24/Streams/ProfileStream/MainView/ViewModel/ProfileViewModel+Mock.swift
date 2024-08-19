//
// ProfileViewModel+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension ProfileViewModel: Mockable {

    static let mockData = ProfileViewModel(
        data: .init(
            notifications: [
                .init(
                    id: "1",
                    text: "Вы должны добавить хотя бы один адрес доставки для оформления заказа."
                )
            ],
            favoriteProducts: (1...10).map {
                .init(
                    id: $0,
                    imageURL: "https://w.forfun.com/fetch/36/36c07e134d6b2fb0f8bdb312fafad549.jpeg",
                    title: "Товар \($0)",
                    price: "\($0) $",
                    description: "Просто моковый товар",
                    tags: []
                )
            }
        )
    )
}
#endif
