//
//  OrdersViewVM+Mock.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

#if DEBUG
extension OrdersViewModel: Mockable {

    static let mockData = OrdersViewModel(
        data: .init(
            orders: .mockData,
            moneyCount: "100 ₽"
        )
    )
}

// MARK: - OrdersViewViewModel OrderInfo

extension [OrdersViewModel.OrderInfo] {

    static let mockData: [OrdersViewModel.OrderInfo] = (1...10).map { .getMockData(id: $0) }
}

extension OrdersViewModel.OrderInfo: Mockable {

    static let mockData: Self = getMockData(id: 1)

    fileprivate static func getMockData(id: Int) -> Self {
        .init(
            id: id,
            date: "2023-06-13 20:15:37",
            price: "7 132.00 ₽",
            cashback: "67 ₽",
            creditedInfo: "Не начислен",
            status: id % 2 == 0 ? .accepted : .cancelled,
            payment: "Счет"
        )
    }
}
#endif
