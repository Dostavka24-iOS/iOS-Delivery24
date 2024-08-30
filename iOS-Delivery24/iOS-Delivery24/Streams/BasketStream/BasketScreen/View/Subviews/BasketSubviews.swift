//
// BasketSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

// MARK: - DLProductHCard HandlerConfiguration

extension BasketView {

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

extension BasketView {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 0) {
                NotificationsView

                ProductCardsView
                    .padding(.top)
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
                        imageKind: .string(product.imageURL.toSport24ImageString),
                        magnifier: product.coeff
                    ),
                    handlerConfiguration: productHandler(
                        id: product.id,
                        price: product.price
                    )
                )
                .frame(height: 174)
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
