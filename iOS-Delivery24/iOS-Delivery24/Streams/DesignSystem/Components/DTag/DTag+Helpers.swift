//
// DTag+Helpers.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension DTag {

    enum IconKind {
        case discount
        case hits
        case new
    }
}

extension DTag.IconKind {

    var icon: ImageResource {
        switch self {
        case .discount:
            return .discount
        case .hits:
            return .hits
        case .new:
            return .new
        }
    }
}
