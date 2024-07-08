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
    }

    var NotificationsView: some View {
        VStack {
            ForEach(viewModel.notifications) { notification in
                // FIXME: iOS-3: Сделать из ДС
                RoundedRectangle(cornerRadius: 16)
                    .fill(.orange)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .overlay {
                        Text(notification.text)
                            .padding(.horizontal)
                    }
            }
        }
    }

    var ProductCardsView: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.products) { product in
                // FIXME: iOS-3: Сделать из ДС
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
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
