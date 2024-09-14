//
// BasketView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct BasketView: View {
    typealias ViewModel = BasketViewModel

    @StateObject var viewModel = ViewModel()
    @EnvironmentObject private var mainVM: MainViewModel
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            screenStateView
                .onAppear(perform: viewModel.onAppear)
                .backport.navigationDestination(for: ViewModel.Screens.self) { screen in
                    switch screen {
                    case .makeOrder:
                        openMakeOrderView
                    case let .product(product):
                        openProductScree(for: product)
                    }
                }
        }
        .onAppear {
            viewModel.setReducers(nav: nav, mainVM: mainVM)
        }
        .environmentObject(nav)
    }

    @ViewBuilder
    private var iOS_View: some View {
        if viewModel.basketIsEmpty {
            BasketIsEmptyView
        } else {
            MainBlock
        }
    }
}

// MARK: - Navigation Destination

private extension BasketView {

    #warning("Указать настоящие данные")
    var openMakeOrderView: some View {
        MakeOrderView(
            viewModel: .init(
                data: .init(
                    deliveryDate: "Не указана",
                    cashback: 0,
                    products: viewModel.data.products,
                    bonusesCount: 0,
                    deliveryPrice: 0,
                    resultSum: viewModel.data.resultSum
                )
            )
        )
    }

    func openProductScree(for product: ProductEntity) -> some View {
        ProductDetailsView(
            viewModel: ProductDetailsViewModel(
                data: .init(product: product)
            )
        )
    }
}

private extension BasketView {

    @ViewBuilder
    var screenStateView: some View {
        ZStack {
            iOS_View
            loaderView.opacity(viewModel.showLoaderView ? 1 : 0)
        }
    }

    var loaderView: some View {
        Color.black.opacity(0.35)
            .ignoresSafeArea()
            .overlay {
                ProgressView().tint(DLColor<IconPalette>.white.color)
            }
    }
}

// MARK: - Preview

#Preview("Моки") {
    BasketView(viewModel: .mockData)
        .environmentObject(MainViewModel.mockData)
}

#Preview("Корзина пуста") {
    BasketView()
        .environmentObject(MainViewModel())
}
