//
//  AllProductsVM+Mock.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

#if DEBUG
extension AllProductsViewModel: Mockable {

    static let mockData = AllProductsViewModel(
        data: .init(
            navigationTitle: "Избранное",
            products: .catalogProducts(.mockData)
        )
    )
}
#endif
