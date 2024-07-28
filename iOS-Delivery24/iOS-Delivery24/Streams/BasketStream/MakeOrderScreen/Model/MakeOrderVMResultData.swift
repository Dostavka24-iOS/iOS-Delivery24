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

    struct ResultData {
        var deliveryDate: String
        var cashback: String
        var images: [UIImage]
        var bonusesCount: String?
        var deliveryPrice: String
        var resultSum: String
    }
}
