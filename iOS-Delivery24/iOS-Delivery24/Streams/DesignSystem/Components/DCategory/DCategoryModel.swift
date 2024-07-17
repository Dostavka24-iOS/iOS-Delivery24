//
// DCategoryModel.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct DCategoryModel: Identifiable {
    let id          : Int
    let imageURL    : URL?
    let title       : String
}

extension MainViewModel.Category {

    var mapper: DCategoryModel {
        .init(
            id: id,
            imageURL: URL(string: imageURL),
            title: title
        )
    }
}
