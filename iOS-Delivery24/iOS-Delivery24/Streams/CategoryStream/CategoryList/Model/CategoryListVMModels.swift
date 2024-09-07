//
// CategoryListVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension CategoryListViewModel {

    struct Reducers {
        var nav: Navigation!
    }

    struct CategoryListVMData {
        var products: [CategoryProductEntity] = []
        var receivedtedCategories: Set<Int> = []
        var navigationTitle: String
        var categories: [CategoryEntity] = []
    }

    struct UIProperties {
        var searchText = ""
    }

    enum Screens: Hashable {
        case category(CategoryEntity)
        case all
    }
}
