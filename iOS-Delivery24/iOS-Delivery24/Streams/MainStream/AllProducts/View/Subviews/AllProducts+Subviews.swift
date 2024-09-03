//
//  AllProducts+Subviews.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

extension AllProductsView {

    var MainContainer: some View {
        Text("AllProductsView")
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        AllProductsView()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension AllProductsView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
