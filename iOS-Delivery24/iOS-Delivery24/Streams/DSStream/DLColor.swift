//
// DLColor.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

final class DLColor<Palette: Hashable> {
    let color: Color
    private let uiColor: UIColor

    init(hexLight: Int, hexDark: Int, alphaLight: CGFloat = 1.0, alphaDark: CGFloat = 1.0) {
        let lightColor = UIColor(hex: hexLight, alpha: alphaLight)
        let darkColor = UIColor(hex: hexDark, alpha: alphaDark)
        let uiColor = UIColor { $0.userInterfaceStyle == .light ? lightColor : darkColor }
        self.uiColor = uiColor
        self.color = Color(uiColor: uiColor)
    }

    init(hexLight: Int, hexDark: Int, alpha: CGFloat = 1.0) {
        let chmColor = DLColor(hexLight: hexLight, hexDark: hexDark, alphaLight: alpha, alphaDark: alpha)
        self.uiColor = chmColor.uiColor
        self.color = chmColor.color
    }

    init(uiColor: UIColor) {
        self.uiColor = uiColor
        self.color = Color(uiColor: uiColor)
    }

    init(color: Color) {
        self.uiColor = .clear
        self.color = color
    }
}

// MARK: - Palettes

enum BackgroundPalette: Hashable {}
enum TextPalette: Hashable {}
enum IconPalette: Hashable {}
enum SeparatorPalette: Hashable {}
enum ShadowPalette: Hashable {}
enum CustomPalette: Hashable {}

// MARK: - BackgroundPalette

extension DLColor where Palette == BackgroundPalette {

    static let lightGray = DLColor(hexLight: 0xF5F5F5, hexDark: 0xF5F5F5)
    static let orange = DLColor(hexLight: 0xFFE8BC, hexDark: 0xFFE8BC)
}

// MARK: - TextPalette

extension DLColor where Palette == TextPalette {

    static let primary = DLColor(color: .primary)
    static let secondary = DLColor(hexLight: 0x999999, hexDark: 0x999999)
    static let blue = DLColor(hexLight: 0x3E45FF, hexDark: 0x3E45FF)
}

// MARK: - IconPalette

extension DLColor where Palette == IconPalette {

    static let primary = DLColor(hexLight: 0x000000, hexDark: 0x000000)
    static let blue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
}

// MARK: - SeparatorPalette

extension DLColor where Palette == SeparatorPalette {

    static let gray = DLColor(hexLight: 0xE0E4E8, hexDark: 0xE0E4E8)
}
