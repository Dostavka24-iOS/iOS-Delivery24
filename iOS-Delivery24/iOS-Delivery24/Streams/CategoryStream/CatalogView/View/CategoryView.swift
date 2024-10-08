//
// CategoryView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct CategoryView: ViewModelable {
    typealias ViewModel = CategoryViewModel

    @StateObject var viewModel: ViewModel
    @StateObject private var nav = Navigation()
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            MainContainer
                .navigationTitle("Каталог")
                .backport.navigationDestination(for: CategoryViewModel.Screens.self) { screen in
                    openNextScreen(for: screen)
                }
        }
        .onAppear {
            viewModel.setReducers(nav: nav, mainVM: mainVM)
        }
        .environmentObject(nav)
        .onAppear(perform: viewModel.fetch)
    }
}

// MARK: - Destinations

private extension CategoryView {

    @ViewBuilder
    func openNextScreen(for screen: CategoryViewModel.Screens) -> some View {
        switch screen {
        case let .categoryList(category, subcats):
            let vm = CategoryListViewModel(
                data: .init(
                    navigationTitle: category.title ?? "Без заголовка",
                    categories: subcats
                )
            )
            CategoryListView(viewModel: vm)
        case let .productScreen(product):
            ProductDetailsView(
                viewModel: .init(
                    data: .init(product: product)
                )
            )
        case let .allProductsScreen(products):
            AllProductsView(
                viewModel: .init(
                    data: .init(
                        navigationTitle: "Популярные товары",
                        products: .product(products)
                    )
                )
            )
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryView(viewModel: .mockData)
        .setScreenSizeForPreview
        .environmentObject(Navigation())
        .environmentObject(MainViewModel.mockData)
}
