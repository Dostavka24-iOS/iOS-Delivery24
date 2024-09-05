//
// ProductEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 21.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct ProductEntity: Decodable, EntityProtocol {
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
    let tags: String?
    let maxInOrder: Int?
    let expirationDate: String?
    let kolvoUpak, newYearFlag, quantity2, countryID: Int?
    let brandTitle: String?
    let whishlistFlag: Bool?
    let brand: Brand

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
        case tags
        case maxInOrder = "max_in_order"
        case expirationDate = "expiration_date"
        case kolvoUpak = "kolvo_upak"
        case newYearFlag = "new_year_flag"
        case quantity2 = "quantity_2"
        case countryID = "country_id"
        case brandTitle = "brand_title"
        case whishlistFlag = "whishlist_flag"
        case brand
    }

    struct Brand: Decodable {
        let id: Int?
        let title: String?
        let createdAt, updatedAt: String?
        let mainFlag: Int?

        enum CodingKeys: String, CodingKey {
            case id, title
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case mainFlag = "main_flag"
        }
    }
}

// MARK: - Mapper

extension ProductEntity {

    var mapper: MainViewModel.Product? {
        guard
            let id,
            let image,
            let priceItem,
            let description
        else {
            Logger.log(kind: .error, message: "Ошибка маппинга продукта с title = \(title ?? "none") id = \(id ?? -1)")
            return nil
        }

        return .init(
            id: id,
            imageURL: image.toSport24ImageString,
            title: title ?? "Без заголовка",
            price: "\(priceItem)₽",
            description: description,
            startCounter: coeff ?? 0,
            magnifier: coeff ?? 1,
            tags: productTags
        )
    }

    var productTags: [Tags] {
        Set([
            hit == 1 ? Tags.hit : nil,
            actionFlag == 1 ? Tags.promotion : nil,
            actionFlag2 == 1 ? Tags.promotion : nil,
            exclusFlag == 1 ? Tags.exclusive : nil,
        ]).compactMap { $0 }
    }
}

// MARK: - Hashable

extension ProductEntity: Identifiable, Hashable {

    static func == (lhs: ProductEntity, rhs: ProductEntity) -> Bool {
        lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.categoryID == rhs.categoryID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(categoryID)
    }
}
