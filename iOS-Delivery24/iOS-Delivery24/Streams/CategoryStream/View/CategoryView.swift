//
// CategoryView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct CategoryView: ViewModelable {

    @StateObject var viewModel: CategoryViewModel

    var body: some View {
        NavigationView {
            MainBlockView
                .navigationTitle("Каталог")
        }
        .onAppear(perform: viewModel.fetch)
    }
}

// MARK: - Preview

#Preview {
    CategoryView(viewModel: .mockData)
}
