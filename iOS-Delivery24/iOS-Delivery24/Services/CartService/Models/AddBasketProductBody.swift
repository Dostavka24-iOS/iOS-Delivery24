//
// AddBasketProductBody.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 07.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct AddBasketProductBody {
    var token: String
    var addressID: Int
    var productID: Int
    var count: Int
}
