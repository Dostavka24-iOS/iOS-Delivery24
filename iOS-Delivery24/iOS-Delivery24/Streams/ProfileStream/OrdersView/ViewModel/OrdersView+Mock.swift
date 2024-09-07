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

// MARK: - OrderEntity

extension [OrderEntity] {

    static let mockData: [OrderEntity] = (1...20).map { .getMockData(id: $0) }
}

extension OrderEntity: Mockable {

    static let mockData: OrderEntity = getMockData(id: 37768)

    fileprivate static func getMockData(id: Int) -> OrderEntity {
        OrderEntity(
            id: id,
            email: "dimapermyakov55@gmail.com",
            phone: "+7(916)855-99-42",
            name: "migthyK1ngRichard",
            userID: 1941,
            totalPrice: "239400.00",
            status: 1,
            createdAt: "2024-09-07 01:56:19",
            updatedAt: "2024-09-07 01:56:19",
            address: "",
            totalCashback: "1197.00",
            chargeFlag: 0,
            bonus: "0.00",
            shippingCost: "0.00",
            sendFlag: 0,
            changedFlag: 0,
            paymentType: 0,
            comment: "",
            deliveryDate: "2024-09-08",
            stockID: 1,
            courierID: 0
        )
    }
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
