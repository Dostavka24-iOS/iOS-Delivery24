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
    StateObject private var nav = Navigation()

    var body: some View {
        NavigationView {
            MainBlockView
                .navigationTitle("Каталог")
        }
        .onAppear(perform: viewModel.fetch)
    }

    var MainContainer: some View {
        switch viewModel.uiProperties.screenState {
        case .initial, .loading:
            ShimmeringView()
        case .error(let apiError):
            ErrorView(error: APIError)
        case .default:
            NavigationStackBackport.NavigationStack(path: $nav.path) {
                MainBlockView
                    .navigationTitle("Каталог")
            }
        }
    }

    @ViewBuilder
    var LoadingView: some View {
    }
}

// MARK: - Preview

#Preview {
    CategoryView(viewModel: .mockData)
}
