//
// OrderEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 07.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct OrderEntity: Decodable, Identifiable, EntityProtocol {
    let id: Int?
    let email: String?
    let phone: String?
    let name: String?
    let userID: Int?
    let totalPrice: String?
    let status: Int?
    let createdAt: String?
    let updatedAt: String?
    let address: String?
    let totalCashback: String?
    let chargeFlag: Int?
    let bonus: String?
    let shippingCost: String?
    let sendFlag: Int?
    let changedFlag: Int?
    let paymentType: Int?
    let comment: String?
    let deliveryDate: String?
    let stockID, courierID: Int?

    enum CodingKeys: String, CodingKey {
        case id, email, phone, name
        case userID = "user_id"
        case totalPrice = "total_price"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address
        case totalCashback = "total_cashback"
        case chargeFlag = "charge_flag"
        case bonus
        case shippingCost = "shipping_cost"
        case sendFlag = "send_flag"
        case changedFlag = "changed_flag"
        case paymentType = "payment_type"
        case comment
        case deliveryDate = "delivery_date"
        case stockID = "stock_id"
        case courierID = "courier_id"
    }
}

// MARK: - Mapper

extension OrderEntity {

    var mapper: DLOrderInfoCell.Configuration? {
        guard
            id != nil,
            let createdAt,
            let totalPrice,
            let price = Double(totalPrice)?.toBeautifulPrice,
            let totalCashback
//            let chargeFlag
        else {
            return nil
        }

        #warning("Узнать что за данные надо сюда подставить")
        return .init(
            date: createdAt,
            price: price,
            cashback: totalCashback,
            creditedInfo: "",
            status: .cancelled,
            payment: "Оплата"
        )
    }
}

