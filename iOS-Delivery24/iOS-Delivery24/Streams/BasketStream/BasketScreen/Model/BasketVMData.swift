//
// BasketVMData.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension BasketViewModel {

    struct BasketData {
        var products: [Product] = []
        var notifications: [NotificationInfo] = []
        var resultSum = 0
    }
}
