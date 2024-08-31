//
// EnvironmentValues+Extensions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {

    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}

#if DEBUG
extension View {

    var setScreenSizeForPreview: some View {
        GeometryReader { geo in
            self.environment(\.mainWindowSize, geo.size)
        }
    }
}
#endif
