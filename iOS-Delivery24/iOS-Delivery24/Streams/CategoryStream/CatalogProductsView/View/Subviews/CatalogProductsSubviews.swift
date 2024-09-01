//
// CatalogProductsSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 01.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension CatalogProductsView {

    var MainContainer: some View {
        VStack(spacing: 0) {
            TopHeaderView
            ScrollView {
                VStack {
                    TagsView
                    ProductsContainer
                }
            }
        }
        .navigationTitle(viewModel.data.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(.backButton)
            }
            ToolbarItem(placement: .topBarTrailing) {
                if let count = viewModel.data.moneyCount {
                    WalletView(moneyCount: count)
                }
            }
        }
    }

    var TagsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { reader in
                HStack(spacing: .SPx2) {
                    ForEach(viewModel.data.tags) { tag in
                        TagView(for: tag)
                    }
                }
                .padding(.top, .SPx2)
                .padding(.bottom, 14)
                .padding(.leading)
                .onChange(of: viewModel.uiProperties.selectedTag) { tag in
                    withAnimation {
                        if let id = tag?.id {
                            reader.scrollTo(id, anchor: .center)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func TagView(for tag: CategoryEntity) -> some View {
        if let title = tag.title, let id = tag.id {
            Text(title)
                .style(size: 15, weight: .semibold, color: Constants.textPrimary)
                .id(id)
                .padding(.horizontal, .SPx3)
                .padding(.vertical, .SPx2)
                .background(Constants.bgGray, in: .rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .fill(tag.id == viewModel.uiProperties.selectedTag?.id
                              ? Constants.separatorBlue
                              : .clear)
                        .padding(.vertical, 2)
                }
                .onTapGesture {
                    viewModel.didSelectTag(for: tag)
                }
        }
    }

    var ProductsContainer: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(), count: 2),
            spacing: .SPx2
        ) {
            ForEach(viewModel.data.products) { product in
                ProductView(for: product)
            }
        }
        .padding(.horizontal)
    }

    var TopHeaderView: some View {
        HStack {
            DLSearchField(text: $viewModel.uiProperties.searchText)
            Button(action: viewModel.didTapSortButton, label: {
                Image(.sort)
                    .frame(width: 24, height: 24)
            })
            Button(action: viewModel.didTapSliderButton, label: {
                Image(.slider)
                    .frame(width: 24, height: 24)
            })
        }
        .padding(.vertical, 13)
        .padding(.horizontal)
        .background(Constants.bgWhite)
    }

    @ViewBuilder
    func ProductView(for product: ProductEntity) -> some View {
        if let model = product.mapper {
            DProductCard(
                product: model.mapper,
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
}

// MARK: - Preview

#Preview {
    NavigationView {
        CatalogProductsView(viewModel: .mockData)
    }
}

// MARK: - Constants

private extension CatalogProductsView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let separatorBlue = DLColor<SeparatorPalette>.link.color
        static let bgGray = DLColor<BackgroundPalette>.gray100.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
    }
}
