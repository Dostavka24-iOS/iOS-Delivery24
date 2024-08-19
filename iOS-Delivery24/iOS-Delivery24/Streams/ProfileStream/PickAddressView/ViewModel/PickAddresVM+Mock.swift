//
// PickAddresVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension PickAddresViewModel: Mockable {

    static let mockData = PickAddresViewModel(
        data: .init(
            addreses: [
                .init(id: "0", locationTitle: "г. Москва, Федора Полетаева 20/1"),
                .init(id: "1", locationTitle: "г. Москва, Каретный ряд 89/3"),
            ]
        )
    )
}
#endif
