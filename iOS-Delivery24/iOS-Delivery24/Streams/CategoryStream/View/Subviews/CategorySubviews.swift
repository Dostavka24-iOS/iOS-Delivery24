//
// CategorySubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension CategoryView {

    var MainBlockView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .SPx8) {
                SectionsContainer
                PopcatContainer
            }
            .padding(.horizontal)
        }
        .searchable(
            text: $viewModel.uiProperties.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        ) 
    }

    var SectionsContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            Text("Категории")
                .style(size: 22, weight: .bold, color: Constants.textPrimary)

            DLCategoryBlock(
                configuration: .init(
                    isShimmering: viewModel.isLoading,
                    cells: viewModel.data.parentCategories.compactMap(\.mapper)
                )
            )
        }
        .padding(.top)
    }

    var PopcatContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            HStack {
                Text("Популярные товары")
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)
                Spacer()
                if !viewModel.isLoading {
                    Button {
                        viewModel.didTapLookAllPopcatProducts()
                    } label: {
                        Text("См. все")
                            .style(size: 17, weight: .regular, color: Constants.textBlue)
                    }
                }
            }

            if viewModel.isLoading {
                ShimmeringProducts
            } else {
                ProductsContainer
            }
        }
    }

    var ProductsContainer: some View {
        LazyVGrid(columns: [
            GridItem(),
            GridItem()
        ], spacing: .SPx2) {
            ForEach(viewModel.data.popProducts, id: \.id) { product in
                if let productData = product.mapper?.mapper {
                    DProductCard(
                        product: productData,
                        handler: .init(
                            didTapLike: {
                                viewModel.didTapLikeProduct(id: productData.id)
                            },
                            didTapBasket: {
                                viewModel.didTapBasketProduct(id: productData.id)
                            }
                        )
                    )
                }
            }
        }
    }

    var ShimmeringProducts: some View {
        LazyVGrid(columns: [
            GridItem(),
            GridItem()
        ], spacing: .SPx2) {
            ForEach(0..<4) { index in
                ShimmeringView()
                    .frame(height: 338)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryView(viewModel: .mockData)
}

// MARK: - Constants

private extension CategoryView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textBlue = DLColor<TextPalette>.darkBlue.color
    }
}
