//
// DColor.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DColor<Palette: Hashable> {

    var color: Color

    static var clear: DColor<Palette> {
        DColor(.clear)
    }

    init(_ color: Color) {
        self.color = color
    }
}

// MARK: - Palettes

enum TagPalette: Hashable {}

// MARK: - TagPalette

extension DColor where Palette == TagPalette {

    static let background = DColor(.tagBG)
    static let hitsIconColor = DColor(.tagHitsIcon)
}
