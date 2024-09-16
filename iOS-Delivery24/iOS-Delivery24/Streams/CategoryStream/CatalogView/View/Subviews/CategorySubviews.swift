//
// CategorySubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension CategoryView {

    @ViewBuilder
    var MainContainer: some View {
        switch viewModel.uiProperties.screenState {
        case let .error(apiError):
            ErrorView(error: apiError, fetchData: viewModel.fetch)
                .frame(maxHeight: .infinity, alignment: .top)
        case .initial, .loading, .default:
            MainBlockView
        }
    }

    var ShimmeringProducts: some View {
        HStack(spacing: .SPx2) {
            Group {
                ShimmeringView()
                ShimmeringView()
            }
            .clipShape(.rect(cornerRadius: 20))
            .frame(height: 338)
        }
    }
}

// MARK: - Main Views

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
                ),
                didSelectIcon: viewModel.didTapParentCategory
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
                Button {
                    viewModel.didTapLookAllPopcatProducts()
                } label: {
                    Text("См. все")
                        .style(size: 17, weight: .regular, color: Constants.textBlue)
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
            ForEach(viewModel.data.popProducts) { product in
                if let productData = product.mapper?.mapper {
                    DProductCard(
                        product: productData,
                        handler: .init(
                            didTapLike: { isLike in
                                viewModel.didTapLikeProduct(id: productData.id, isLike: isLike)
                            },
                            didTapBasket: { startCounter in
                                viewModel.didTapBasketProduct(id: productData.id, counter: startCounter)
                            }
                        )
                    )
                    .onTapGesture {
                        viewModel.didTapProductCard(with: product)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryView(viewModel: .mockData)
        .setScreenSizeForPreview
        .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension CategoryView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textBlue = DLColor<TextPalette>.darkBlue.color
    }
}
