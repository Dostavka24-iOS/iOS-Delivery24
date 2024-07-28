//
// BasketViewModel+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension BasketViewModel: Mockable {

    static var mockData: BasketViewModel {
        let products = [BasketViewModel.Product].mockData
        return BasketViewModel(
            data: .init(
                products: products,
                notifications: .mockData,
                resultSum: {
                    let sum = products.reduce(0) { (currentSum, product) in
                        let price = Double(product.price) ?? 0
                        return currentSum + price
                    }
                    return sum
                }()
            )
        )
    }
}

// MARK: Product

private extension [BasketViewModel.Product] {

    static let mockData: Self = (1...20).map {
        .init(
            id: String($0),
            imageURL: "https://f.vividscreen.info/soft/404d9e6c16fe1a0fbd4a1b1a30cd946f/Anime-Kiss-2560x1600.jpg",
            price: "\(Double($0) * 100.5)",
            unitPrice: "\($0).03",
            name: "Жвачка \"Лов Из\" Банан/Клубника"
        )
    }
}

// MARK: NotificationInfo

private extension [BasketViewModel.NotificationInfo] {

    static let mockData: Self = [
        .init(id: "1", text: "Вы должны добавить хотя бы один адрес доставки для оформления заказа."),
        .init(id: "2", text: "Для оформления заказа вы должны подтвердить Email и телефон в «Личном кабинете»")
    ]
}
#endif
