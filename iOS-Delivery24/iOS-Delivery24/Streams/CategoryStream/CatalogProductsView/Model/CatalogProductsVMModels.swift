//
// CatalogProductsVMModels.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 01.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension CatalogProductsViewModel {

    struct CatalogProductsVMData {
        var products: [ProductEntity] = []
        var tags: [CategoryEntity] = []
        var moneyCount: String?
        var navigationTitle: String
    }

    struct UIProperties {
        var selectedTags: Set<CategoryEntity> = []
        var lastSelectedTag: CategoryEntity?
        var searchText = ""
    }

    struct Reducers {
        var nav: Navigation!
    }
}
