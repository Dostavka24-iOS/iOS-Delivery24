//
// MainView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

extension MainViewModel {

    enum Screens: Identifiable, Hashable {
        static func == (lhs: MainViewModel.Screens, rhs: MainViewModel.Screens) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        case product(ProductEntity)

        var id: String {
            switch self {
            case .product: "product"
            }
        }
    }
}

struct MainView: ViewModelable {
    typealias ViewModel = MainViewModel
    typealias Section = ViewModel.Section
    typealias Product = ViewModel.Product

    @StateObject var viewModel = ViewModel()
    @StateObject var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            iOS_View
                .backport.navigationDestination(for: MainViewModel.Screens.self) { screen in
                    switch screen {
                    case .product(let product):
                        let vm = ProductDetailsView.ViewModel(
                            data: .init(product: product)
                        )
                        ProductDetailsView(viewModel: vm)
                            .zIndex(2)
                    }
                }
        }
        .preferredColorScheme(.light)
        .viewSize(size: $viewModel.uiProperties.size)
        .onAppear(perform: viewModel.fetchData)
        .onAppear {
            viewModel.setReducers(nav: nav)
        }
    }

    @ViewBuilder
    private var iOS_View: some View {
        switch viewModel.uiProperties.screenState {
        case .error(let error):
//            ErrorView(error: error)
            MainBlock
        case .default:
            MainBlock
        case .loading, .initial:
            LoadingView
        }
    }
}

// MARK: - UI Subviews

private extension MainView {

    var LoadingView: some View {
        ZStack {
            Image(.gradientBG)
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 240)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DLColor<BackgroundPalette>.lightGray.color)
        .overlay(alignment: .bottom) {
            ProgressView()
                .offset(y: -50)
        }
    }
}

// MARK: - Preview

#Preview("Сеть") {
    MainView()
}

#Preview {
    MainView(viewModel: .mockData)
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let searchText = String(localized: "search").capitalized
    }
}
