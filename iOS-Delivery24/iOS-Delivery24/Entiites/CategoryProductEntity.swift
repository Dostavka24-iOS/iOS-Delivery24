//
// CategoryProductEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 03.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct CategoryProductEntity: Decodable, EntityProtocol {
    let id: Int?
    let sku: String?
    let title: String?
    let price: String?
    let quantity: Int?
    let description: String?
    let image: String?
    let categoryID: Int?
    let priceSale: String?
    let cashback: Double?
    let brandID: Int?
    let manufacturerID: Int?
    let createdAt: String?
    let updatedAt: String?
    let slug: String?
    let actionFlag: Int?
    let coeff: Int?
    let ean: String?
    let hit: Int?
    let actionFlag2: Int?
    let exclusFlag: Int?
    let rating: Int?
    let priceItem: String?
    let maxInOrder: Int?
    let expirationDate: String?
    let kolvoUpak: Int?
    let newYearFlag: Int?
    let quantity2: Int?
    let countryID: Int?
    let brandTitle: String?
    let whishlistFlag: Bool?
    let brand: ProductEntity.Brand

    enum CodingKeys: String, CodingKey {
        case id
        case sku
        case title
        case price
        case quantity
        case description
        case image
        case categoryID = "category_id"
        case priceSale = "price_sale"
        case cashback
        case brandID = "brand_id"
        case manufacturerID = "manufacturer_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case slug
        case actionFlag = "action_flag"
        case coeff
        case ean
        case hit
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
        case brandTitle = "brand_title"
        case whishlistFlag = "whishlist_flag"
        case brand
    }
}

// MARK: - Mapper

extension CategoryProductEntity {

    var mapper: DProductCardModel? {
        guard
            let id,
            let priceItem,
            let description
        else {
            Logger.log(kind: .error, message: "Ошибка маппинга продукта с title = \(title ?? "none") id = \(id ?? -1)")
            return nil
        }

        guard
            let doublePriceItem = Double(priceItem),
            doublePriceItem != 0
        else {
            Logger.log(kind: .debug, message: "Цена продукта с title = \(title ?? "none") id = \(id) равна нулю")
            return nil
        }

        return DProductCardModel(
            id: id,
            imageURL: image?.toSport24ImageString.toURL,
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

    var mapperToProductEntity: ProductEntity {
        ProductEntity(
            id: id,
            sku: sku,
            title: title,
            price: price,
            quantity: quantity,
            description: description,
            image: image,
            categoryID: categoryID,
            priceSale: priceSale,
            cashback: {
                guard let cashback else { return nil }
                return String(cashback)
            }(),
            brandID: brandID,
            manufacturerID: manufacturerID,
            createdAt: createdAt,
            updatedAt: updatedAt,
            slug: slug,
            actionFlag: actionFlag,
            actionCountdown: nil,
            coeff: coeff,
            ean: ean,
            hit: hit,
            actionFlag2: actionFlag2,
            exclusFlag: exclusFlag,
            rating: rating,
            priceItem: priceItem,
            tags: nil,
            maxInOrder: maxInOrder,
            expirationDate: expirationDate,
            kolvoUpak: kolvoUpak,
            newYearFlag: newYearFlag,
            quantity2: quantity2,
            countryID: countryID,
            brandTitle: brandTitle,
            whishlistFlag: whishlistFlag,
            brand: brand
        )
    }
}
