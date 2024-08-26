//
// StartLoadingView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct StartLoadingView: View {

    var body: some View {
        LoadingView
    }

    var LoadingView: some View {
        ZStack {
            Image(.gradientBG)
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 240)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DLColor<BackgroundPalette>.lightGray.color)
        .overlay(alignment: .bottom) {
            ProgressView()
                .offset(y: -200)
        }
    }
}

// MARK: - Preview

#Preview {
    StartLoadingView()
}
