//
// CatalogProductsView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 01.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct CatalogProductsView: ViewModelable {

    @StateObject var viewModel: CatalogProductsViewModel
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel
    @EnvironmentObject private var categoryListVM: CategoryListViewModel

    var body: some View {
        MainContainer
            .backport.navigationDestination(for: CatalogProductsViewModel.Screens.self) { screen in
                openNextScreen(for: screen)
            }
            .onAppear {
                viewModel.setReducers(nav: nav, mainVM: mainVM, categoryListVM: categoryListVM)
            }
    }
}

// MARK: - Navigation Destination

private extension CatalogProductsView {

    func openNextScreen(for screen: CatalogProductsViewModel.Screens) -> some View {
        switch screen {
        case let .product(productEntity):
            ProductDetailsView(
                viewModel: ProductDetailsView.ViewModel(
                    data: .init(product: productEntity)
                )
            )
        }
    }
}

// MARK: - Preview

#Preview {
    CatalogProductsView(viewModel: .mockData)
        .environmentObject(Navigation())
        .environmentObject(MainViewModel.mockData)
        .environmentObject(CategoryListViewModel.mockData)
}
