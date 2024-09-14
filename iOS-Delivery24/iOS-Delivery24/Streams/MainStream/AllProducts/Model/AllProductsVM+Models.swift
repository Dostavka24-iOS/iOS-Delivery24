//
//  AllProductsVM+Models.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation

extension AllProductsViewModel {

    struct AllProductsVMData {
        var navigationTitle: String
        var products: ProductsType = .product([])

        enum ProductsType {
            case product([ProductEntity])
            case catalogProducts([CategoryProductEntity])
        }
    }

    struct UIProperties {}

    struct Reducers {
        var nav: Navigation!
        var mainVM: MainViewModel!
    }

    enum Screens: Hashable {}
}
