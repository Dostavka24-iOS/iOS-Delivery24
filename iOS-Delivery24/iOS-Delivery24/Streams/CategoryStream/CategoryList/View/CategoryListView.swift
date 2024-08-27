//
// CategoryListView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct CategoryListView: ViewModelable {

    @StateObject var viewModel: CategoryListViewModel
    @EnvironmentObject private var nav: Navigation

    var body: some View {
        MainContainer
            .onAppear {
                viewModel.setReducers(nav: nav)
            }
    }
}

// MARK: - Preview

#Preview {
    CategoryListView(viewModel: .mockData)
        .environmentObject(Navigation())
}
