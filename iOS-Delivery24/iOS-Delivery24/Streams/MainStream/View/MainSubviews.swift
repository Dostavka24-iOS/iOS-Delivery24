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
                    TagsSection

                    VStack(spacing: 32) {
                        BannerSection

                        ProductSections
                    }
                    .padding(.top)
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
        // FIXME: iOS-3: Заменить на самостоятельный компонент, который будет возвращать id
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.sections) { section in
                    TagView(title: section.title).onTapGesture {
                        viewModel.uiProperties.lastSelectedSection = "scroll_section_id_\(section.id)"
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
    }

    var BannerSection: some View {
        BannersBlock()
            .frame(height: 180)
    }

    @ViewBuilder
    var ProductSections: some View {
        ForEach(viewModel.sections) { section in
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
        products: [Product],
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
                .style(size: 22, weight: .bold, color: Constants.sectionTitleColor)

            Spacer()

            Button(action: action, label: {
                Text(Constants.lookMoreTitle)
                    .style(size: 17, weight: .regular, color: Constants.lookMoreColor)
            })
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func SectionProducts(products: [Product]) -> some View {
        let size = uiProperties.size
        let cardWidth = size.width < size.height ? size.width / 2.23 : size.height / 2.23
        let cardHeight = size.width < size.height ? cardWidth * 2.01 : size.height / 1.5

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(products) { product in
                    ProductCard(for: product)
                        .frame(width: cardWidth, height: cardHeight)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - DS Views

extension MainView {

    func BannersBlock() -> some View {
        // FIXME: iOS-3: Заменить на баннер ДС
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray)
            .frame(maxWidth: .infinity, maxHeight: 460)
            .padding(.horizontal)
    }

    func ProductCard(for product: Product) -> some View {
        // FIXME: iOS-3: Заменить на карточку товара ДС
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray)
    }

    func TagView(title: String) -> some View {
        // FIXME: iOS-3: Заменить на компонент тега ДС
        Text(title)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.gray, in: .rect(cornerRadius: 12))
    }
}

// MARK: - Preview

#Preview("Portrait") {
    MainView(viewModel: .mockData)
}

@available(iOS 17, *)
#Preview("Landscape", traits: .landscapeLeft) {
    MainView(viewModel: .mockData)
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let lookMoreTitle = {
            let localizedString = String(localized: "look_more")
            return localizedString.prefix(1).capitalized + localizedString.dropFirst()
        }()

        // FIXME: iOS-3: Поправить на цвет ДС
        static let lookMoreColor = Color.primary
        static let sectionTitleColor = Color.primary
        // -
    }
}
