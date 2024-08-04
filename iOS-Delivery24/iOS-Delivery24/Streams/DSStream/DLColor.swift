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
    static let lightGray2 = DLColor(hexLight: 0xCCCCCC, hexDark: 0xCCCCCC)
    static let lightGray3 = DLColor(hexLight: 0xF9F9F9, hexDark: 0xF9F9F9)
    static let orange = DLColor(hexLight: 0xFFE8BC, hexDark: 0xFFE8BC)
    static let blue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
    static let white = DLColor(color: .white)
    static let overlay = DLColor<BackgroundPalette>(hexLight: 0x000000, hexDark: 0x000000, alpha: 0.4)
}

// MARK: - TextPalette

extension DLColor where Palette == TextPalette {

    static let primary = DLColor(color: .primary)
    static let white = DLColor(color: .white)
    static let secondary = DLColor(hexLight: 0x999999, hexDark: 0x999999)
    static let blue = DLColor(hexLight: 0x3E45FF, hexDark: 0x3E45FF)
    static let darkBlue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
    static let success = DLColor(hexLight: 0x34C759, hexDark: 0x34C759)
}

// MARK: - IconPalette

extension DLColor where Palette == IconPalette {

    static let primary = DLColor(hexLight: 0x000000, hexDark: 0x000000)
    static let secondary = DLColor(hexLight: 0x3C3C434D, hexDark: 0x3C3C434D, alpha: 0.3)
    static let blue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
}

// MARK: - SeparatorPalette

extension DLColor where Palette == SeparatorPalette {

    static let gray = DLColor(hexLight: 0xE0E4E8, hexDark: 0xE0E4E8)
}

// MARK: - ShadowPalette

extension DLColor where Palette == ShadowPalette {

    static let dark = DLColor(hexLight: 0x00000014, hexDark: 0x00000014, alpha: 0.08)
}
