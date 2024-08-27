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
            userModel: .mockData,
            notifications: [
                .init(
                    id: "1",
                    text: "Вы должны добавить хотя бы один адрес доставки для оформления заказа."
                )
            ],
            favoriteProducts: (1...10).map {
                .mockData(id: $0)
            }
        )
    )
}
#endif
