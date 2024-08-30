//
// BasketVMProduct.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension BasketViewModel {

    struct Product: Identifiable {
        var id: Int
        /// Фото
        var imageURL: String
        /// Цена продукта
        var price: Double
        /// Цена за штуку
        var unitPrice: Double
        /// Название товара
        var name: String
        /// Кэшбек продукта
        var cashback: String
        /// Начальная счёт продукта
        var startCount: Int
        /// Magnifier
        var coeff: Int
    }
}

// MARK: - Mapper

extension ProductEntity {

    var mapperToBasketProduct: BasketViewModel.Product? {
        guard
            let id,
            let image,
            let priceItem,
            let cashback,
            let coeff,
            let title,
            let priceNumber = Double(priceItem),
            let unitPrice = Double(priceItem)
        else {
            return nil
        }
        return .init(
            id: id,
            imageURL: image,
            price: priceNumber * Double(coeff),
            unitPrice: unitPrice,
            name: title,
            cashback: cashback,
            startCount: coeff,
            coeff: coeff
        )
    }
}
