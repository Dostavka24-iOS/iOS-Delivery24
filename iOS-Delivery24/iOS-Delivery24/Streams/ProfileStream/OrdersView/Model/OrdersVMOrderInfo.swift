//
// OrdersVMOrderInfo.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 06.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension OrdersViewModel {

    struct OrderInfo: Identifiable {
        let id: Int
        let date: String
        let price: String
        let cashback: String
        let creditedInfo: String
        let status: DLOrderInfoCell.Configuration.Status
        let payment: String
    }
}

// MARK: - Mapper

extension OrdersViewModel.OrderInfo {

    var mapper: DLOrderInfoCell.Configuration {
        .init(
            date: date,
            price: price,
            cashback: cashback,
            creditedInfo: creditedInfo,
            status: status,
            payment: payment
        )
    }
}
