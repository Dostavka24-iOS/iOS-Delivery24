//
// CatalogProductsVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 01.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension CatalogProductsViewModel: Mockable {

    static let mockData = CatalogProductsViewModel(
        data: .init(
            products: [MainViewModel.Section].fakeEntityProducts,
            tags: (69...75).map { .mockData(id: $0) }, 
            navigationTitle: "Жевательная резинка"
        )
    )
}

extension CategoryEntity: Mockable {

    static let mockData = CategoryEntity(
        id: 0,
        title: "Жевательная резинка",
        status: nil,
        parentID: nil,
        createdAt: nil,
        updatedAt: nil,
        extID: nil,
        showOnMain: nil,
        image: nil,
        ageLimitFlag: nil,
        text: nil
    )
    static func mockData(id: Int) -> CategoryEntity {
        CategoryEntity(
            id: id,
            title: "Жевательная резинка",
            status: nil,
            parentID: nil,
            createdAt: nil,
            updatedAt: nil,
            extID: nil,
            showOnMain: nil,
            image: nil,
            ageLimitFlag: nil,
            text: nil
        )
    }
}
#endif
