//
// CategoryEntity.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

struct CategoryEntity: Decodable {
    let id: Int?
    let title: String?
    let status: Int?
    let parentID: Int?
    let createdAt: String?
    let updatedAt: String?
    let extID: String?
    let showOnMain: Int?
    let image: String?
    let ageLimitFlag: Int?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case status
        case parentID = "parent_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case extID = "ext_id"
        case showOnMain = "show_on_main"
        case image
        case ageLimitFlag = "age_limit_flag"
        case text
    }
}

// MARK: - Mapper

extension CategoryEntity {

    var mapper: DLCategoryBlock.Configuration.CellData? {
        guard
            id != nil,
            let title,
            let imageURL = image?.toSport24ImageString.toURL
        else {
            return nil
        }
        
        return .init(title: title, imageURL: imageURL)
    }
}
