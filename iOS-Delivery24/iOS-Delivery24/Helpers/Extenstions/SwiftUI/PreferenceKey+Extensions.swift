//
// PreferenceKey+Extensions.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {

    func offsetX(_ addObserver: Bool, completion: @escaping (CGRect) -> Void) -> some View {
        frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)

                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    }
                }
            }
    }
}
