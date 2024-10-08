//
// BasketSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

// MARK: - Screen State

extension BasketView {

    @ViewBuilder
    var screenStateView: some View {
        switch viewModel.uiProperties.screenState {
        case .initial, .loading, .default:
            emptyOrContentView
        case .error(let apiError):
            ErrorView(error: apiError)
        }
    }
}

// MARK: - DLProductHCard HandlerConfiguration

private extension BasketView {

    func productHandler(id: Int, price: Double) -> DLProductHCard.HandlerConfiguration {
        .init(
            didTapPlus: { counter in
                viewModel.didTapPlus(
                    id: id,
                    counter: counter,
                    productPrice: price
                )
            },
            didTapMinus: { counter in
                viewModel.didTapMinus(
                    id: id,
                    counter: counter,
                    productPrice: price
                )
            },
            didTapLike: { isSelected in
                viewModel.didTapLike(id: id, isSelected: isSelected)
            },
            didTapDelete: { counter in
                viewModel.didTapDelete(
                    id: id,
                    counter: counter,
                    productPrice: price
                )
            }
        )
    }
}

// MARK: - UI Subviews

private extension BasketView {

    @ViewBuilder
    var emptyOrContentView: some View {
        if viewModel.basketIsEmpty {
            BasketIsEmptyView
        } else {
            mainBlockContainer
        }
    }

    var loaderView: some View {
        VStack(spacing: .SPx3) {
            ForEach(0...10, id: \.self) { _ in
                ShimmeringView()
                    .frame(height: 174)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
    }

    var mainBlockContainer: some View {
        ScrollView {
            VStack(spacing: 0) {
                NotificationsView
                if viewModel.showLoaderView {
                    loaderView
                        .padding(.top)
                } else {
                    ProductCardsView
                        .padding(.top)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 150)
        }
        .navigationTitle(Constants.navigationTitle.capitalized)
        .overlay(alignment: .bottom) {
            OverlayView
        }
    }

    var NotificationsView: some View {
        VStack {
            ForEach(viewModel.data.notifications) { notification in
                DLNotification(text: notification.text)
            }
        }
    }

    var ProductCardsView: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.products) { product in
                DLProductHCard(
                    configuration: .init(
                        title: product.name,
                        price: product.price.toBeautifulPrice,
                        unitPrice: "\(product.unitPrice.toBeautifulPrice)/шт",
                        cornerPrice: product.cashback,
                        startCount: product.startCount,
                        isLiked: false,
                        imageKind: .string(product.imageURL),
                        magnifier: product.coeff
                    ),
                    handlerConfiguration: productHandler(
                        id: product.id,
                        price: product.price
                    )
                )
                .frame(height: 174)
                .contentShape(.rect)
                .onTapGesture {
                    viewModel.didTapProduct(id: product.id)
                }
            }
        }
    }

    var BasketIsEmptyView: some View {
        DontResultView(
            configuration: .init(
                resource: .cryingEmoji,
                title: Constants.placeholderText.title,
                subtitle: Constants.placeholderText.subtitle
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            DLBasketMakeOrderButton(
                configuration: .init(
                    state: .default,
                    title: Constants.openCatalogButtonText.title,
                    subtitle: Constants.openCatalogButtonText.subtitle,
                    isDisable: false
                ),
                didTapButton: viewModel.didTapOpenCatalog
            )
            .buttonShadow
            .padding(.horizontal, 12)
            .padding(.bottom)
        }
        .navigationTitle(Constants.navigationTitle.capitalized)
    }

    var OverlayView: some View {
        DLMinimumOrderSumView(
            needPrice: viewModel.needPrice.toBeautifulPrice,
            total: viewModel.data.resultSum.toBeautifulPrice,
            isReady: viewModel.needPrice == 0,
            minimumSum: viewModel.data.MINIMUM_PRICE.toBeautifulPrice,
            isOpened: $viewModel.uiProperties.isOpenedSheet,
            didTapMakeOrderButton: viewModel.didTapMakeOrderButton
        )
        .buttonShadow
        .ignoresSafeArea(edges: [.top])
    }
}

// MARK: - Helpers

private extension View {

    var buttonShadow: some View {
        clipShape(.rect).shadow(
            color: DLColor<ShadowPalette>.dark.color,
            radius: 16,
            x: 0,
            y: -4
        )
    }
}

// MARK: - Preview

#Preview {
    BasketView(viewModel: .mockData)
        .environmentObject(MainViewModel.mockData)
}

#Preview("Shimmering") {
    let vm = BasketViewModel.mockData
    return BasketView(viewModel: vm)
        .environmentObject(MainViewModel.mockData)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                vm.uiProperties.screenState = .loading
            }
        }
}

#Preview("Корзина пустая") {
    BasketView()
        .environmentObject(MainViewModel())
}

// MARK: - Constants

private extension BasketView {

    enum Constants {
        static let navigationTitle = String(localized: "basket")
        static let openCatalogButtonText = (
            title: String(localized: "В каталог"),
            subtitle: String(localized: "К поиску более 1 млн товаров")
        )
        static let placeholderText = (
            title: String(localized: "Корзина пуста"),
            subtitle: String(localized: "Мотивирующий текст")
        )
    }
}
