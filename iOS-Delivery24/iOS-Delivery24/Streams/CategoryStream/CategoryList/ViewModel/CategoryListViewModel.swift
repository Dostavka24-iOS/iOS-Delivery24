//
// CategoryListViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol CategoryListViewModelProtocol: ViewModelProtocol {
    // MARK: Reducers
    func setReducers(nav: Navigation)
    // MARK: Actions
    func didTapCell(category: CategoryEntity)
}

final class CategoryListViewModel: CategoryListViewModelProtocol {
    @Published var data: CategoryListVMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()

    init(
        data: CategoryListVMData,
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }

    var rows: [CategoryEntity] {
        guard !uiProperties.searchText.isEmpty else {
            return data.categories
        }
        
        return data.categories.filter {
            $0.title?.contains(uiProperties.searchText) == true
        }
    }
}

// MARK: - Actions

extension CategoryListViewModel {

    func didTapCell(category: CategoryEntity) {
        reducers.nav.addScreen(screen: Screens.category(category))
    }
}

// MARK: - Reducers

extension CategoryListViewModel {

    func setReducers(nav: Navigation) {
        reducers.nav = nav
    }
}

import SwiftUI
#Preview {
    NavigationView {
        CategoryListView(viewModel: .mockData)
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}
