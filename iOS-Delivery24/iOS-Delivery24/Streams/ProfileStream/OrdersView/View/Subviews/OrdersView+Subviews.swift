//
//  OrdersView+Subviews.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

extension OrdersViewView {

    var MainContainer: some View {
        Text("OrdersViewView")
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        OrdersViewView()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension OrdersViewView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
