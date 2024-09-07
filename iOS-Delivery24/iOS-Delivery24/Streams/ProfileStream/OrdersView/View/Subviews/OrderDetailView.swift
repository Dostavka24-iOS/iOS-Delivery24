//
// OrderDetailView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 06.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    let order: OrderDetailEntity
    @EnvironmentObject private var viewModel: OrdersViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerView
                productsContainer
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - UI Subviews

private extension OrderDetailView {

    var headerView: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            Text(order.createdAt ?? "")
                .style(size: 22, weight: .bold, color: Constants.textPrimary)
            Text(order.status == 1 ? "Принят" : "Отменён")
                .style(
                    size: 17,
                    weight: .regular,
                    color: order.status == 1 ? Constants.textGreen : Constants.textRed
                )
        }
        .padding(.top)
        .padding(.bottom, .SPx2)
    }

    @ViewBuilder
    var productsContainer: some View {
        ForEach(order.orderProducts ?? []) { product in
            if
                let id = product.id,
                let title = product.title,
                let price = product.price,
                let doublePrice = Double(price),
                let orderCount = product.orderCount,
                let priceItem = product.priceItem,
                let priceItemTitle = Double(priceItem)?.toBeautifulPrice,
                let cashback = product.cashback,
                let imageURL = product.image?.toSport24ImageString.toURL,
                let coeff = product.coeff
            {
                DLProductHCard(
                    configuration: .init(
                        title: title,
                        price: (doublePrice * Double(orderCount)).toBeautifulPrice,
                        unitPrice: "\(orderCount * coeff) шт · \(priceItemTitle)/шт ",
                        cornerPrice: cashback,
                        startCount: coeff,
                        isLiked: false,
                        imageKind: .url(imageURL),
                        magnifier: coeff,
                        buttonKind: .info
                    )
                )
                .frame(height: 174)
                .contentShape(.rect)
                .onTapGesture {
                    viewModel.didTapProduct(id: id)
                }
            }
        }
    }
}

// MARK: - DLProductHCard HandlerConfiguration

private extension OrderDetailView {


}

// MARK: - Preview

#Preview {
    OrderDetailView(
        order: .mockData
    )
    .environmentObject(OrdersViewModel.mockData)
}

// MARK: - Constants

private extension OrderDetailView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textRed = DLColor<TextPalette>.red.color
        static let textGreen = Color.green
    }
}
