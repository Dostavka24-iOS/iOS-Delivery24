//
// Text+Extenstions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension Text {

    func style(size: CGFloat, weight: Font.Weight, color: Color) -> some View {
        font(.system(size: size, weight: weight))
            .foregroundStyle(color)
    }
}
