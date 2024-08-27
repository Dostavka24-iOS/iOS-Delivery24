//
// CategoryListVM+Mock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension CategoryListViewModel: Mockable {

    static let mockData = CategoryListViewModel(
        data: CategoryListVMData(
            navigationTitle: "Кондитерские изделия", 
            categories: (0...10).map {
                CategoryEntity(
                    id: $0,
                    title: "Жевательная резинка: Жевательная резинка: Жевательная резинка: \($0!)",
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
        )
    )
}
#endif
