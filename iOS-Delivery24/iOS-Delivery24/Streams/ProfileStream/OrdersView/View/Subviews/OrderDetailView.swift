//
// OrderDetailView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 06.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    let order: OrdersViewModel.OrderInfo
    let products: [BasketViewModel.Product]
    @EnvironmentObject private var viewModel: OrdersViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerView
                productsContainer
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - UI Subviews

private extension OrderDetailView {

    var headerView: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            Text(order.date)
                .style(size: 22, weight: .bold, color: Constants.textPrimary)
            Text(order.status.rawValue.capitalized)
                .style(size: 17, weight: .regular, color: order.status.color)
        }
        .padding(.top)
        .padding(.bottom, .SPx2)
    }

    @ViewBuilder
    var productsContainer: some View {
        ForEach(products) { product in
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

// MARK: - DLProductHCard HandlerConfiguration

private extension OrderDetailView {

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

// MARK: - Preview

#Preview {
    OrderDetailView(
        order: .mockData,
        products: .mockData
    )
    .environmentObject(OrdersViewModel.mockData)
}

// MARK: - Constants

private extension OrderDetailView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
