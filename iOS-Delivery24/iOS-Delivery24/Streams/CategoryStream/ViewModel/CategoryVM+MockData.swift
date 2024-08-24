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
            userToken: "wFbiEwN3fRrujnou"
        )
    )
}
#endif
