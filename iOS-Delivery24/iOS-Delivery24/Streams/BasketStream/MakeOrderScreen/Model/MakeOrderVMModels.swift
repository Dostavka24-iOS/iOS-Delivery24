//
// MakeOrderVMResultData.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import UIKit
import Foundation

extension MakeOrderViewModel {
    
    struct UIProperies {
        var bonusesIncluded = false
        var bonusesCount = ""
    }

    struct ResultData {
        var deliveryDate: String
        var cashback: Double
        var images: [UIImage]
        var bonusesCount: Int?
        var deliveryPrice: Double
        var resultSum: Double
    }
}
