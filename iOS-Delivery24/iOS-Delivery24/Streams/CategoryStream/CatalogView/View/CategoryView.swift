//
// CategoryView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

struct CategoryView: ViewModelable {
    typealias ViewModel = CategoryViewModel

    @StateObject var viewModel: ViewModel
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            MainContainer
                .navigationTitle("Каталог")
                .backport.navigationDestination(for: ViewModel.Screens.self) { screen in
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
                        Text(product.title ?? "none")
                    }
                }
        }
        .environmentObject(nav)
        .onAppear(perform: viewModel.fetch)
        .onAppear {
            viewModel.setReducers(nav: nav)
        }
    }
}

private extension CategoryView {

    @ViewBuilder
    var MainContainer: some View {
        switch viewModel.uiProperties.screenState {
        case .error(let apiError):
            ErrorView(error: apiError, fetchData: viewModel.fetch)
                .frame(maxHeight: .infinity, alignment: .top)
        case .initial, .loading:
            ShimmeringBlock
        case .default:
            MainBlockView
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryView(viewModel: .mockData)
        .environmentObject(Navigation())
}
