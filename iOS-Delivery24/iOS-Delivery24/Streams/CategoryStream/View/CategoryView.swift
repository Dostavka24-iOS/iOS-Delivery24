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

    @StateObject var viewModel: CategoryViewModel
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            MainContainer
                .navigationTitle("Каталог")
        }
        .onAppear(perform: viewModel.fetch)
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
}
