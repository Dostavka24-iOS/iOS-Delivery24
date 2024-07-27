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
            DLMinimumOrderSumView(
                needPrice: "4 210.4 ₽",
                total: "2 789.60 ₽",
                isReady: false,
                didTapMakeOrderButton: {}
            )
            .clipShape(.rect)
            .shadow(
                color: DLColor<ShadowPalette>.dark.color,
                radius: 16,
                x: 32,
                y: -4
            )
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
}

// MARK: - Preview

#Preview {
    BasketView(viewModel: .mockData)
}

// MARK: - Constants

private extension BasketView {

    enum Constants {
        static let navigationTitle = String(localized: "basket")
    }
}
