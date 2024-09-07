//
// MakeOrderVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension MakeOrderViewModel: Mockable {

    static let mockData = MakeOrderViewModel(
        data: .init(
            deliveryDate: "Доставка 4 – 6 июля",
            cashback: 35.37,
            products: .mockData,
            deliveryPrice: 0,
            resultSum: 25789.60
        )
    )
}
#endif

