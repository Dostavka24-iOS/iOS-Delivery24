//
// Double+Extensions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 29.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension Double {

    var toBeautifulPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₽"
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "ru_RU")

        guard let formattedString = formatter.string(from: NSNumber(value: self)) else {
            return "0 ₽"
        }

        return formattedString
    }
}
