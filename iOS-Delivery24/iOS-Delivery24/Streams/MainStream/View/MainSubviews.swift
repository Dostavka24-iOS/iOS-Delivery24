//
// MainSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MainView {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(viewModel.sections) { section in
                    SectionBlock(
                        sectionTitle: section.title.capitalized,
                        products: section.products,
                        action: {}
                    )
                }
            }
        }
    }

    var BannersBlock: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.pink)
            .frame(maxWidth: .infinity, maxHeight: 460)
            .padding(.horizontal)
    }

    func ProductCard(for product: Product) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray)
    }
}

// MARK: - Section Views

extension MainView {

    func SectionBlock(
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

    func SectionProducts(products: [Product]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(products) { product in
                    ProductCard(for: product)
                    // FIXME: Не забыть сделать расчёты
                        .frame(width: 167, height: 338)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview

#Preview {
    MainView(viewModel: .mockData)
}

// MARK: - Constants

private extension MainView {

    enum Constants {
        static let lookMoreTitle = String(localized: "look_more").capitalized
        // FIXME: iOS-3: Поправить на цвет ДС
        static let lookMoreColor = Color.primary
        static let sectionTitleColor = Color.primary
        // -
    }
}
