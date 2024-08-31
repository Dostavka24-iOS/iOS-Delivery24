//
// CategoryVM+MockData.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

#if DEBUG
extension CategoryViewModel: Mockable {

    static let mockData = CategoryViewModel(
        data: .init(
            userToken: "wFbiEwN3fRrujnou",
            categories: categories,
            parentCategories: categories
        ),
        uiProperties: .init(screenState: .initial)
    )

    private static let categories = (0...9).map {
        CategoryEntity(
            id: $0,
            title: "Моковый заголовок: \($0!)",
            status: nil,
            parentID: 0,
            createdAt: nil,
            updatedAt: nil,
            extID: nil,
            showOnMain: nil,
            image: URL?.fakeURL?.absoluteString,
            ageLimitFlag: nil,
            text: nil
        )
    }
}
#endif
