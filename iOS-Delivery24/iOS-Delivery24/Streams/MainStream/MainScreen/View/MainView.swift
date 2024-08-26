//
// MainView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

struct MainView: ViewModelable {
    typealias ViewModel = MainViewModel
    typealias Section = ViewModel.Section
    typealias Product = ViewModel.Product

    @EnvironmentObject var viewModel: ViewModel
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            iOS_View
                .backport.navigationDestination(for: MainViewModel.Screens.self) { screen in
                    switch screen {
                    case .product(let product):
                        let vm = ProductDetailsView.ViewModel(
                            data: .init(product: product)
                        )
                        ProductDetailsView(viewModel: vm)
                    }
                }
        }
        .preferredColorScheme(.light)
        .viewSize(size: $viewModel.uiProperties.size)
        .onAppear {
            viewModel.setReducers(nav: nav)
        }
    }

    @ViewBuilder
    private var iOS_View: some View {
        switch viewModel.uiProperties.screenState {
        case .error(let error):
            ErrorView(error: error, fetchData: viewModel.fetchData)
        case .default:
            MainBlock
        case .loading, .initial:
            StartLoadingView()
        }
    }
}

// MARK: - Preview

#Preview("Сеть") {
    MainView()
        .environmentObject(MainViewModel.mockData)
}

#Preview {
    MainView()
        .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let searchText = String(localized: "search").capitalized
    }
}
