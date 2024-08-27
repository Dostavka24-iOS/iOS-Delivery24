//
// ProductDetailsVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension ProductDetailsViewModel: Mockable {

    static let mockData = ProductDetailsViewModel(
        data: ProductDetailsVMData(
            product: .mockData
        )
    )
}
#endif
