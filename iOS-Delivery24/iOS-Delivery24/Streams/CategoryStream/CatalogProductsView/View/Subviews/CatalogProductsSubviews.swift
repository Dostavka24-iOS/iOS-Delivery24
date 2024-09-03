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
                .padding(.horizontal)
                .onAppear {
                    guard let id = viewModel.uiProperties.lastSelectedTag?.id else { return }
                    reader.scrollTo(id, anchor: .center)
                }
                .onChange(of: viewModel.uiProperties.lastSelectedTag) { tag in
                    guard let id = tag?.id else { return }
                    withAnimation {
                        reader.scrollTo(id, anchor: .center)
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
                        .fill(viewModel.tagIsSelected(with: tag)
                              ? Constants.separatorBlue
                              : .clear)
                        .padding(.vertical, 2)
                }
                .onTapGesture {
                    viewModel.didSelectTag(for: tag)
                }
        }
    }

    @ViewBuilder
    var ProductsContainer: some View {
        switch viewModel.uiProperties.screenState {
        case .default:
            if viewModel.products.isEmpty {
                EmptyProductView
            } else {
                ProductCards
            }
        case .loading, .error, .initial:
            LoadingView
        }
    }

    var LoadingView: some View {
        VStack(spacing: .SPx2) {
            ForEach(0...10, id: \.self) { _ in
                HStack {
                    ShimmeringView()
                        .clipShape(.rect(cornerRadius: 20))
                        .frame(height: 250)
                    ShimmeringView()
                        .clipShape(.rect(cornerRadius: 20))
                        .frame(height: 250)
                }
            }
        }
        .padding(.horizontal)
    }

    var EmptyProductView: some View {
        DontResultView(
            configuration: .init(
                resource: .cryingEmoji,
                title: Constants.emptyTitle,
                subtitle: Constants.emptySubtitle
            )
        )
    }

    var ProductCards: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(), count: 2),
            spacing: .SPx2
        ) {
            ForEach(viewModel.products) { product in
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
    func ProductView(for product: CategoryProductEntity) -> some View {
        if let model = product.mapper {
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
            .onTapGesture {
                viewModel.didTapProductCard(for: product)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CatalogProductsView(viewModel: .mockData)
        .environmentObject(Navigation())
        .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension CatalogProductsView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let separatorBlue = DLColor<SeparatorPalette>.link.color
        static let bgGray = DLColor<BackgroundPalette>.gray100.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
        static let emptyTitle = "Пусто"
        static let emptySubtitle = "Продуктов данных категорий не обнаруженно"
    }
}
