//
// BasketSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension BasketView {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 0) {
                NotificationsView

                ProductCardsView
                    .padding(.top)
            }
            .padding(.horizontal)
        }
        .navigationTitle(Constants.navigationTitle.capitalized)
        .overlay(alignment: .bottom) {
            OverlayView
        }
    }

    var NotificationsView: some View {
        VStack {
            ForEach(viewModel.notifications) { notification in
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
                        price: "\(product.price) ₽",
                        unitPrice: "\(product.unitPrice) ₽/шт",
                        // FIXME: Понять, что это
                        cornerPrice: "1.14",
                        // FIXME: Придумать что-то со счётчиком
                        count: "0",
                        // FIXME: Придумать что-то с лайком
                        isLiked: true,
                        imageKind: .string(product.imageURL)
                    )
                )
                .frame(height: 174)
            }
        }
    }

    var BasketIsEmptyView: some View {
        VStack(spacing: 16) {
            Image(.cryingEmoji)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

            VStack(spacing: 4) {
                Text(Constants.placeholderText.title)
                    .style(size: 17, weight: .regular, color: DLColor<TextPalette>.primary.color)

                Text(Constants.placeholderText.subtitle)
                    .style(size: 13, weight: .regular, color: DLColor<TextPalette>.secondary.color)
            }
        }
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
        }
        .navigationTitle(Constants.navigationTitle.capitalized)
    }

    var OverlayView: some View {
        DLMinimumOrderSumView(
            needPrice: "4 210.4 ₽",
            total: "2 789.60 ₽",
            isReady: false,
            isOpened: $viewModel.uiProperties.isOpenedSheet,
            didTapMakeOrderButton: {}
        )
        .buttonShadow
        .ignoresSafeArea(edges: .top)
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
}

#Preview("Корзина пустая") {
    BasketView()
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
