//
// BasketVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension BasketViewModel {

    struct BasketData {
        let MINIMUM_PRICE = 7000.0

        var products: [Product] = []
        var notifications: [NotificationInfo] = []
        var resultSum = 0.0
    }

    struct UIProperties {
        var isOpenedSheet = false
        var screenState: ScreenState = .initial
    }

    struct Reducers {
        var nav: Navigation!
        var mainVM: MainViewModel!
    }

    enum Screens: Hashable {
        case product(ProductEntity)
        case makeOrder
    }
}
