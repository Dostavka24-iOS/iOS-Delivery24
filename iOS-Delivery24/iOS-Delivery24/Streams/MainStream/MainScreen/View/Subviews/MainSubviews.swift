//
// MainSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MainView {
    var uiProperties: ViewModel.UIProperties { viewModel.uiProperties }

    var MainBlock: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack(spacing: 0) {
                    // FIXME: iOS-4: Добавить сетевую логику
                    MainHeaderView(
                        textInput: $viewModel.uiProperties.searchText,
                        moneyCount: "102",
                        handler: .init(
                            didTapWallet: viewModel.didTapWallet,
                            didTapSelectAddress: viewModel.didTapSelectAddress
                        )
                    )

                    TagsSection
                        .padding(.top, 13)

                    VStack(spacing: 32) {
                        BannerSection

                        ProductSections
                    }
                    .padding(.top)

                    PopularCategoriesSection
                        .padding(.top, 32)
                }
                .onChange(of: uiProperties.lastSelectedSection) { newValue in
                    guard let id = newValue else { return }
                    withAnimation {
                        scrollViewProxy.scrollTo(id, anchor: .top)
                    }
                }
            }
        }
    }
}

// MARK: - Assembling Sections

extension MainView {

    var TagsSection: some View {
        DTagsSection(sections: viewModel.data.sections) { lastSelectedSection in
            viewModel.uiProperties.lastSelectedSection = lastSelectedSection
        }
    }

    var BannerSection: some View {
        DBanners(pages: viewModel.data.banners.compactMap(\.mapper))
            .frame(height: 180)
    }

    @ViewBuilder
    var ProductSections: some View {
        ForEach(viewModel.data.sections) { section in
            ProductSectionBlock(
                sectionTitle: section.title.capitalized,
                products: section.products
            ) {
                viewModel.didTapSectionLookMore(section: section)
            }
            .id("scroll_section_id_\(section.id)")
        }
    }
}

// MARK: - Section Views

extension MainView {

    func ProductSectionBlock(
        sectionTitle: String,
        products: [ProductEntity],
        action: @escaping DLVoidBlock
    ) -> some View {
        VStack(spacing: 8) {
            SectionTitle(title: sectionTitle, action: action)

            SectionProducts(products: products)
        }
    }

    func SectionTitle(title: String, action: @escaping DLVoidBlock) -> some View {
        HStack {
            Text(title)
                .style(size: 22, weight: .bold, color: Constants.textPrimary)

            Spacer()

            Button(action: action, label: {
                Text(Constants.lookMoreTitle)
                    .style(size: 17, weight: .regular, color: Constants.lookMoreColor)
            })
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func SectionProducts(products: [ProductEntity]) -> some View {
        let size = uiProperties.size
        let cardWidth = size.width < size.height ? size.width / 2.23 : size.height / 2.23
        let cardHeight = size.width < size.height ? cardWidth * 2.01 : size.height / 1.5

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(products, id: \.id) { product in
                    if let productModel = product.mapper {
                        ProductCard(for: productModel)
                            .frame(width: cardWidth, height: cardHeight)
                            .onTapGesture {
                                viewModel.didTapProductCard(product: product)
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    var PopularCategoriesSection: some View {
        VStack(spacing: 8) {
            SectionTitle(
                title: Constants.popularCategoriesSectionTitle,
                action: viewModel.didTapLookPopularSection
            )

            LazyVGrid(
                columns: Array(repeating: GridItem(spacing: 8), count: 2),
                spacing: 8
            ) {
                ForEach(viewModel.data.popcats) { popcat in
                    if let category = popcat.mapper {
                        DCategory(category: category)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - DS Views

extension MainView {

    func ProductCard(for product: Product) -> some View {
        DProductCard(
            product: product.mapper,
            handler: .init(
                didTapLike: {
                    viewModel.didTapLike(id: product.id)
                },
                didTapBasket: {
                    viewModel.didTapAddInBasket(id: product.id)
                }
            )
        )
        .padding(.vertical, 1)
        .contentShape(.rect)
    }
}

// MARK: - Preview

#Preview("Portrait") {
    MainView(viewModel: .mockData)
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let popularCategoriesSectionTitle = String(
            localized: "popular_categories"
        ).capitalized
        static let lookMoreTitle = String(localized: "look_more").capitalizingFirstLetter
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let lookMoreColor = DLColor<TextPalette>.darkBlue.color
    }
}
