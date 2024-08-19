//
// MainVMCategory.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation


extension MainViewModel {

    struct Category: Identifiable {
        let id          : Int
        let imageURL    : String
        let title       : String
    }
}

// MARK: - Mock Data

#if DEBUG
extension MainViewModel.Category: Mockable {

    static let mockData = MainViewModel.Category(
        id: 0,
        imageURL: "https://www.dostavka24.net/upload/banners/7593918_1110kh460jpg.jpg",
        title: "Категория"
    )
}
#endif
