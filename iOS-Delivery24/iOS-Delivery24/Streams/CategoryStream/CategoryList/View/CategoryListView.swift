//
// CategoryListView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct CategoryListView: ViewModelable {

    @StateObject var viewModel: CategoryListViewModel
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        MainContainer
            .backport.navigationDestination(for: CategoryListViewModel.Screens.self) { screen in
                openNextScreen(for: screen)
            }
            .onAppear {
                viewModel.setReducers(nav: nav)
            }
    }
}

// MARK: - Navigation Destination

private extension CategoryListView {

    @ViewBuilder
    func openNextScreen(for screen: CategoryListViewModel.Screens) -> some View {
        switch screen {
        case let .category(category):
            CatalogProductsView(
                viewModel: .init(
                    data: .init(
                        tags: viewModel.rows,
                        moneyCount: mainVM.data.userModel?.balance,
                        navigationTitle: category.title ?? "Загаловок не задан"
                    ),
                    uiProperties: .init(
                        selectedTags: [category],
                        lastSelectedTag: category
                    )
                )
            )
            .environmentObject(viewModel)
        case .all:
            Text("All")
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryListView(viewModel: .mockData)
        .environmentObject(Navigation())
        .environmentObject(MainViewModel.mockData)
}
