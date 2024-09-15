//
//  OrdersView+Mock.swift
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

// MARK: - OrderDetailEntity

extension [OrderDetailEntity] {

    static let mockData: [OrderDetailEntity] = (1...10).map { .getMockData(id: $0) }
}

extension OrderDetailEntity: Mockable {

    static let mockData = getMockData(id: 37769)

    fileprivate static func getMockData(id: Int) -> Self {
        OrderDetailEntity(
            id: id,
            email: "dimapermyakov55@gmail.com",
            phone: "+7(916)855-99-42",
            name: "migthyK1ngRichard",
            userID: 1941,
            totalPrice: "615968.64",
            status: 1,
            createdAt: "2024-09-07 02:15:36",
            updatedAt: "2024-09-07 02:15:36",
            address: "",
            totalCashback: "3079.84",
            chargeFlag: 0,
            bonus: "100.00",
            shippingCost: "0.00",
            sendFlag: 0,
            changedFlag: 0,
            paymentType: 0,
            comment: "",
            deliveryDate: "2024-09-08",
            stockID: 1,
            courierID: 0,
            orderProducts: .mockData
        )
    }
}


extension [OrderDetailEntity.OrderProduct] {

    static let mockData: [OrderDetailEntity.OrderProduct] = (1...10).map { .getMockData(id: $0) }
}

extension OrderDetailEntity.OrderProduct: Mockable {

    static let mockData = getMockData(id: 2570)

    fileprivate static func getMockData(id: Int) -> Self {
        OrderDetailEntity.OrderProduct(
            id: id,
            sku: "85a532ff-7382-11eb-80d5-2c4d5451998e",
            title: "Напиток MacCoffee Original кофейный растворимый 3 в 1 100пак*20г",
            price: "1116.00",
            quantity: 1786,
            description: "Maccoffee 3в1 — это приготовленный из кофе высшего сорта, сахара и сливок растворимый кофейный напиток,который не только наполняет энергией, но и дарит богаство ощущений благодаря насыщенному вкусу, а также удобству употребления в любое время при любых обстоятельствах.",
            image: "/import/import_files/85/85a532ff738211eb80d52c4d5451998e_36f5eb65ba3811eb80dc2c4d5451998e.png",
            categoryID: 69,
            priceSale: "0.00",
            cashback: "0.50",
            brandID: 359,
            manufacturerID: 0,
            createdAt: "2021-07-21 19:12:34",
            updatedAt: "2024-09-07 01:06:38",
            slug: "",
            actionFlag: 0,
            actionCountdown: nil,
            coeff: 100,
            ean: "8887290101028",
            hit: 1,
            actionFlag2: 1,
            exclusFlag: 0,
            rating: 225400,
            priceItem: "11.16",
            maxInOrder: 0,
            expirationDate: "730",
            kolvoUpak: 1,
            newYearFlag: 0,
            quantity2: 25,
            countryID: 0,
            orderCount: 500,
            brandTitle: ""
        )
    }
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
