//
// BasketView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct BasketView: View {
    typealias ViewModel = BasketViewModel

    @StateObject var viewModel = ViewModel()

    var body: some View {
        iOS_View
    }

    @ViewBuilder
    private var iOS_View: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                if viewModel.basketIsEmpty {
                    BasketIsEmptyView
                } else {
                    MainBlock
                }
            }
        } else {
            NavigationView {
                MainBlock
            }
        }
    }
}

// MARK: - Preview

#Preview("Моки") {
    BasketView(viewModel: .mockData)
}

#Preview("Корзина пуста") {
    BasketView()
}
