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
        var id: String
        /// Фото
        var imageURL: String
        /// Цена продукта
        var price: Double
        /// Цена за штуку
        var unitPrice: String
        /// Название товара
        var name: String
    }
}
