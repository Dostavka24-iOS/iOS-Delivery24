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
                        let price = product.price
                        return currentSum + price
                    }
                    return sum
                }()
            )
        )
    }
}

// MARK: Product

extension [BasketViewModel.Product] {

    static let mockData: Self = (1...20).map {
        .init(
            id: $0,
            imageURL: "https://steamuserimages-a.akamaihd.net/ugc/257084214452671873/B6DC9814D0F20104BCD77BE4F5C7952E7DB74BAD/?imw=512&amp;imh=320&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true",
            price: 230,
            unitPrice: 10,
            name: "Жвачка \"Лов Из\" Банан/Клубника",
            cashback: "12",
            startCount: 23, 
            coeff: 23
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
