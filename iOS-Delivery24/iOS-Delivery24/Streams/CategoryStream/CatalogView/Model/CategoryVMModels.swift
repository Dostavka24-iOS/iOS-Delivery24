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

    struct Reducers {
        var nav: Navigation!
    }

    enum Screens {
        case categoryList(CategoryEntity, [CategoryEntity])
        case productScreen(ProductEntity)
    }
}

// MARK: - Screens

extension CategoryViewModel.Screens: Identifiable, Hashable {

    var id: String {
        switch self {
        case .categoryList: "categoryList"
        case .productScreen: "productScreen"
        }
    }
    
    static func == (lhs: CategoryViewModel.Screens, rhs: CategoryViewModel.Screens) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
