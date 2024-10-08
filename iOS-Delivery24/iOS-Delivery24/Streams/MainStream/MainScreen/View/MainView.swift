//
// MainView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct MainView: ViewModelable {
    typealias ViewModel = MainViewModel
    typealias Section = ViewModel.Section
    typealias Product = ViewModel.Product

    @EnvironmentObject var viewModel: ViewModel
    @StateObject private var nav = Navigation()
    @FocusState var isFocused: Bool

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            iOS_View
                .backport.navigationDestination(for: MainViewModel.Screens.self) { screen in
                    openNextScreen(for: screen)
                }
                .fullScreenCover(isPresented: $viewModel.uiProperties.sheets.showAddressView) {
                    PickAddressSheet
                }
        }
        .preferredColorScheme(.light)
        .viewSize(size: $viewModel.uiProperties.size)
        .onAppear {
            viewModel.setReducers(nav: nav)
        }
        .environmentObject(nav)
    }
}

// MARK: - UI Subviews & Destinations

private extension MainView {

    @ViewBuilder
    func openNextScreen(for screen: MainViewModel.Screens) -> some View {
        switch screen {
        case let .product(product):
            ProductDetailsView(
                viewModel: ProductDetailsView.ViewModel(
                    data: .init(product: product)
                )
            )
        case let .lookMore(section):
            AllProductsView(
                viewModel: .init(
                    data: .init(
                        navigationTitle: section.title.capitalized,
                        products: .product(section.products)
                    )
                )
            )
        case let .lookMoreCaterogyProduct(title, subcats):
            CategoryListView(
                viewModel: .init(
                    data: .init(
                        navigationTitle: title,
                        categories: subcats
                    )
                )
            )
        }
    }

    var PickAddressSheet: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            if let token = viewModel.data.userModel?.token {
                PickAddressView(
                    viewModel: .init(
                        data: .init(userToken: token)
                    )
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        CloseSheetButton
                    }
                }
            }
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
