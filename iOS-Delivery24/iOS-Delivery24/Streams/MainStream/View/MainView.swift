//
// MainView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct MainView: ViewModelable {
    typealias ViewModel = MainViewModel
    typealias Section = ViewModel.Section
    typealias Product = ViewModel.Product

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        iOS_View
            .viewSize(size: $viewModel.uiProperties.size)
            .onSubmit(of: .search, viewModel.didTapSearchProduct)
    }

    @ViewBuilder
    private var iOS_View: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                MainBlock
            }
        } else {
            NavigationView {
                MainBlock
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MainView(viewModel: .mockData)
}

// MARK: - Helper

private extension View {

    func viewSize(size: Binding<CGSize>) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size.wrappedValue = proxy.size
                    }
            }
        }
    }
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let searchText = String(localized: "search").capitalized
    }
}
