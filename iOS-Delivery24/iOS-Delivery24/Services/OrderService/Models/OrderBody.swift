//
// OrderBody.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 07.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct OrderBody {
    var token: String
    var addressID: Int
    var bonus: Int
    var products: [OrderProduct]

    struct OrderProduct {
        var id: String
        var count: Int
    }
}
