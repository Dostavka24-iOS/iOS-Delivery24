//
// DProductCardModel.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct DProductCardModel: Identifiable {
    let id: Int
    var imageURL: URL?
    var isLike = false
    let title: String
    let price: String
    let description: String
    let startCounter: Int
    let magnifier: Int
    let tags: [Tags]
}

// MARK: - Mapper

extension MainViewModel.Product {

    var mapper: DProductCardModel {
        .init(
            id: id,
            imageURL: URL(string: imageURL),
            title: title,
            price: price,
            description: description,
            startCounter: startCounter,
            magnifier: magnifier,
            tags: tags
        )
    }
}
