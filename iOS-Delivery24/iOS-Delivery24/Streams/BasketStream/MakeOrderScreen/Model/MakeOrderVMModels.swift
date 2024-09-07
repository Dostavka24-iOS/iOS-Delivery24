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
        var showSuccessView = false
        var bonusesIncluded = false
        var bonusesCount = ""
        var buttonState: ButtonState = .default
    }

    struct MakeOrderVMData {
        var deliveryDate: String
        var cashback: Double
        var products: [BasketViewModel.Product]
        var bonusesCount: Int?
        var deliveryPrice: Double
        var resultSum: Double
    }

    struct Reducers {
        var nav: Navigation!
        var mainVM: MainViewModel!
    }
}
