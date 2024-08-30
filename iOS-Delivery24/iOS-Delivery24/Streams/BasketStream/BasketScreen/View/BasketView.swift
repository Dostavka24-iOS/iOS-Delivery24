//
// BasketView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

struct BasketView: View {
    typealias ViewModel = BasketViewModel

    @StateObject var viewModel = ViewModel()
    @EnvironmentObject private var mainVM: MainViewModel
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            iOS_View.onAppear(perform: viewModel.onAppear)
        }
        .onAppear {
            viewModel.setReducers(nav: nav, mainVM: mainVM)
        }
        .environmentObject(nav)
    }

    @ViewBuilder
    private var iOS_View: some View {
        if viewModel.basketIsEmpty {
            BasketIsEmptyView
        } else {
            MainBlock
        }
    }
}

// MARK: - Preview

#Preview("Моки") {
    BasketView(viewModel: .mockData)
        .environmentObject(MainViewModel.mockData)
}

#Preview("Корзина пуста") {
    BasketView()
        .environmentObject(MainViewModel())
}
