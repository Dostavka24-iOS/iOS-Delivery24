//
// AddressEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 31.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct AddressEntity: Decodable {
    let id: Int?
    let userID: Int?
    let title: String?
    let city: String?
    let street: String?
    let house: String?
    let flat: String?
    let createdAt: String?
    let updatedAt: String?
    let stockID: Int?
//    let cart": null,
    let minOrder: Int?
    let minDate: String?
    let minSum: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case city
        case street
        case house
        case flat
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case stockID = "stock_id"
        case minOrder = "min_order"
        case minDate = "min_date"
        case minSum = "min_sum"
    }
}

// MARK: - Mapper

extension AddressEntity {

    var mapper: PickAddresViewModel.AddressInfo? {
        guard let id, let title else { return nil }
        return .init(id: id, locationTitle: title)
    }
}
