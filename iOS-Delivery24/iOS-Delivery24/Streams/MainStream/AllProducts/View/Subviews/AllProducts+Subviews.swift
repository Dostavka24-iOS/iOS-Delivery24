//
//  AllProducts+Subviews.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

extension AllProductsView {

    var MainContainer: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: Array(repeating: GridItem(), count: 2),
                spacing: .SPx2
            ) {
                ProductsContainer
            }
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.data.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let count = viewModel.moneyCount {
                    WalletView(moneyCount: count)
                }
            }
        }
    }

    @ViewBuilder
    var ProductsContainer: some View {
        switch viewModel.data.products {
        case let .catalogProducts(products):
            ForEach(products) { product in
                if let model = product.mapper {
                    DSProductCard(model: model).onTapGesture {
                        viewModel.didTapProductCard(for: product)
                    }
                }
            }
        case let .product(products):
            ForEach(products) { product in
                if let model = product.mapper?.mapper {
                    DSProductCard(model: model).onTapGesture {
                        viewModel.didTapProductCard(for: product)
                    }
                }
            }
        }
    }

    func DSProductCard(model: DProductCardModel) -> some View {
        DProductCard(
            product: model,
            handler: .init(
                didTapLike: { isLike in
                    viewModel.didTapProductLike(productID: model.id, isLike: isLike)
                },
                didTapPlus: { counter in
                    viewModel.didTapProductPlus(productID: model.id, counter: counter)
                },
                didTapMinus: { counter in
                    viewModel.didTapProductMinus(productID: model.id, counter: counter)
                },
                didTapBasket: { counter in
                    viewModel.didTapProductBasket(productID: model.id, counter: counter)
                }
            )
        )
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        AllProductsView(viewModel: .mockData)
    }
    .environmentObject(MainViewModel.mockData)
    .environmentObject(Navigation())
}

// MARK: - Constants

private extension AllProductsView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
