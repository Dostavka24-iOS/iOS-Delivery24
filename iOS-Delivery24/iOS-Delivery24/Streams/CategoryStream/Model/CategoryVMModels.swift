//
// CategoryVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension CategoryViewModel {

    struct CategoryVMData {
        var userToken: String
        var categories: [CategoryEntity] = []
        var parentCategories: [CategoryEntity] = []
        var popProducts: [ProductEntity] = []
    }

    struct UIProperties {
        var screenState: ScreenState = .initial
        var searchText = ""
    }
}
