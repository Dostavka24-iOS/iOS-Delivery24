//
// BannerEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 23.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct BannerEntity: Decodable {
    let id: Int?
    let title: String?
    let image: String?
    let link: String?
    let sortOrder: Int?
    let text: String?
    let createdAt: String?
    let updatedAt: String?
    let type: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case link
        case sortOrder = "sort_order"
        case text
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type
    }
}

// MARK: - Mapper

extension BannerEntity {

    var mapper: BannerPage? {
        guard
            let id,
            let imageString = image?.toSport24ImageURL,
            let url = URL(string: imageString)
        else {
            return nil
        }

        return .init(id: id, url: url)
    }
}
