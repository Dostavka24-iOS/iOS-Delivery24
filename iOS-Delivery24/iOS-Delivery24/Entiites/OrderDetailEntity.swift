//
// OrderDetailEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 07.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct OrderDetailEntity: Decodable, Identifiable, Hashable {
    let id: Int?
    let email, phone, name: String?
    let userID: Int?
    let totalPrice: String?
    let status: Int?
    let createdAt, updatedAt, address, totalCashback: String?
    let chargeFlag: Int?
    let bonus, shippingCost: String?
    let sendFlag, changedFlag, paymentType: Int?
    let comment: String?
    let deliveryDate: String?
    let stockID, courierID: Int?
    let orderProducts: [OrderProduct]?

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
        case orderProducts = "order_proudcts"
    }
}

// MARK: - OrderProudct

extension OrderDetailEntity {

    struct OrderProduct: Decodable, Identifiable, Hashable {
        let id: Int?
        let sku, title, price: String?
        let quantity: Int?
        let description, image: String?
        let categoryID: Int?
        let priceSale, cashback: String?
        let brandID, manufacturerID: Int?
        let createdAt, updatedAt, slug: String?
        let actionFlag: Int?
        let actionCountdown: String?
        let coeff: Int?
        let ean: String?
        let hit, actionFlag2, exclusFlag, rating: Int?
        let priceItem: String?
        let maxInOrder: Int?
        let expirationDate: String?
        let kolvoUpak, newYearFlag, quantity2, countryID: Int?
        let orderCount: Int?
        let brandTitle: String?

        enum CodingKeys: String, CodingKey {
            case id, sku, title, price, quantity, description, image
            case categoryID = "category_id"
            case priceSale = "price_sale"
            case cashback
            case brandID = "brand_id"
            case manufacturerID = "manufacturer_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case slug
            case actionFlag = "action_flag"
            case actionCountdown = "action_countdown"
            case coeff, ean, hit
            case actionFlag2 = "action_flag_2"
            case exclusFlag = "exclus_flag"
            case rating
            case priceItem = "price_item"
            case maxInOrder = "max_in_order"
            case expirationDate = "expiration_date"
            case kolvoUpak = "kolvo_upak"
            case newYearFlag = "new_year_flag"
            case quantity2 = "quantity_2"
            case countryID = "country_id"
            case orderCount = "order_count"
            case brandTitle = "brand_title"
        }
    }
}
