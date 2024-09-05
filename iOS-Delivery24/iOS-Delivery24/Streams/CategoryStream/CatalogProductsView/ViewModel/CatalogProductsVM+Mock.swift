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
            tags: (2...10).map { .getMockEntity(id: $0) },
            navigationTitle: "Жевательная резинка"
        ),
        uiProperties: .init(
            selectedTags: [
                .getMockEntity(id: 1),
                .getMockEntity(id: 2),
            ],
            lastSelectedTag: .getMockEntity(id: 2)
        )
    )
}

// MARK: - CategoryProductEntity

extension [CategoryProductEntity]: Mockable {

    static let mockData: [CategoryProductEntity] = (1...20).map {
        .getMockEntity(id: $0)
    }
}

extension CategoryProductEntity: Mockable {

    static let mockData = getMockEntity(id: 0)

    fileprivate static func getMockEntity(id: Int) -> Self {
        CategoryProductEntity(
           id: id,
           sku: nil,
           title: "Заголовок",
           price: "77.52",
           quantity: nil,
           description: "Просто описание товара",
           image: "/import/import_files/59/590865776dfc11eb80d52c4d5451998e_6b941accd8da11eb80e02c4d5451998e.png",
           categoryID: 2,
           priceSale: "0.00",
           cashback: 0.39,
           brandID: 67,
           manufacturerID: 0,
           createdAt: "2021-07-21 19:12:17",
           updatedAt: "2024-09-02 22:02:52",
           slug: "",
           actionFlag: nil,
           coeff: 1,
           ean: "8076809572064",
           hit: 0,
           actionFlag2: 0,
           exclusFlag: 0,
           rating: 1363,
           priceItem: "77.52",
           maxInOrder: 0,
           expirationDate: "730",
           kolvoUpak: 24,
           newYearFlag: 0,
           quantity2: 34,
           countryID: 0,
           brandTitle: "Barilla",
           whishlistFlag: false,
           brand: ProductEntity.Brand(
               id: 67,
               title: "Barilla",
               createdAt: "2021-08-11 09:12:08",
               updatedAt: "2021-08-11 09:12:08",
               mainFlag: 0
           )
       )
    }
}

// MARK: - CategoryEntity

extension [CategoryEntity] {

    static let mockData: [CategoryEntity] = (1...10).map {
        .getMockEntity(id: $0)
    }
}

extension CategoryEntity: Mockable {

    static let mockData = getMockEntity(id: 0)
    
    fileprivate static func getMockEntity(id: Int) -> CategoryEntity {
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
