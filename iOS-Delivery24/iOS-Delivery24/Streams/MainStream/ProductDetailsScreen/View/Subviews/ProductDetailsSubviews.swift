//
// ProductDetailsSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension ProductDetailsView {
    var product: ProductEntity { viewModel.data.product }

    var MainContainer: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageContainer
                BottomContainer
            }
            .padding(.horizontal)
            .padding(.bottom, 70)
        }
        .overlay(alignment: .bottom) {
            AddIntoBasketButton
        }
    }
}

extension ProductDetailsView {

    var AddIntoBasketButton: some View {
        Button {
            viewModel.didTapAddIntoBasketButton()
        } label: {
            VStack(spacing: .SPx0_5) {
                HStack(spacing: 8) {
                    Image(.plus)
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(DLColor<IconPalette>.white.color)

                    Text("В корзину")
                        .style(size: 16, weight: .semibold, color: Constants.textWhite)
                }

                if let title = viewModel.makeBasketButtonTitle {
                    Text(title)
                        .style(size: 13, weight: .semibold, color: Constants.textWhite)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(DLColor<BackgroundPalette>.blue.color, in: .rect(cornerRadius: 12))
        .padding(.horizontal)
    }
}

// MARK: - Image Container

extension ProductDetailsView {

    @ViewBuilder
    var ImageContainer: some View {
        if let imageURL = product.image?.toSport24ImageString.toURL {
            DLImageView(
                configuration: .init(
                    imageKind: .url(imageURL),
                    contentMode: .fit
                )
            )
            .frame(height: 457)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 24))
            .overlay(alignment: .topLeading) {
                TagsStack
            }
            .overlay(alignment: .topTrailing) {
                ButtonsContainer
            }
        }
    }

    var TagsStack: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ForEach(product.productTags, id: \.rawValue) { productTag in
                Text(productTag.rawValue)
                    .style(size: 11, weight: .semibold, color: DLColor<TextPalette>.white.color)
                    .padding(.horizontal, .SPx1)
                    .padding(.vertical, .SPx0_5)
                    .background(productTag.backgroundColor, in: .rect(cornerRadius: 7))
            }
        }
        .padding()
    }

    var ButtonsContainer: some View {
        HStack {
            Button {
                viewModel.didTapShare()
            } label: {
                Image(.share)
                    .frame(width: 12, height: 12)
                    .padding(10)
            }
            .background(Constants.bgWhite, in: .circle)


            Button {
                viewModel.didTapLike()
            } label: {
                Image(.heart)
                    .frame(width: 12, height: 12)
                    .padding(10)
            }
            .background(Constants.bgWhite, in: .circle)
        }
        .padding(12)
    }
}

// MARK: - Bottom Container

extension ProductDetailsView {

    var BottomContainer: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ProductTitleView
            DetailContainer
        }
    }

    @ViewBuilder
    var ProductTitleView: some View {
        if let title = product.title {
            Text(title)
                .style(size: 22, weight: .bold, color: Constants.textPrimary)
        }
    }

    var DetailContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            BrandTitle
            PriceContainer
            ProductAdditionalInfo
            DescriptionContainer
        }
    }

    @ViewBuilder
    var BrandTitle: some View {
        if let brandName = product.brand.title {
            HStack(spacing: .SPx1) {
                Text("Бренд:")
                    .style(size: 17, weight: .regular, color: Constants.textPrimary)

                Text(brandName)
                    .style(size: 17, weight: .regular, color: Constants.textLink)
            }
        }
    }

    @ViewBuilder
    var PriceContainer: some View {
        if 
            let priceString = product.priceItem,
            let price = Double(priceString)?.toBeautifulPrice,
            let cashback = product.cashback
        {
            HStack(spacing: .SPx1) {
                Text(price)
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)
                Text("/шт")
                    .style(size: 17, weight: .regular, color: DLColor<TextPalette>.gray800.color)
                Spacer()
                WalletView(moneyCount: cashback, size: .size17)
            }
            .padding()
            .background(DLColor<BackgroundPalette>.gray100.color, in: .rect(cornerRadius: 16))
        }
    }

    @ViewBuilder
    var ProductAdditionalInfo: some View {
        SubtitleInfo(
            imageResource: .box,
            title: "В упаковке:",
            text: {
                guard let text = product.kolvoUpak else { return nil }
                return "\(text) шт."
            }()
        )
        SubtitleInfo(
            imageResource: .time,
            title: "Срок годности:",
            text: viewModel.calculateDate
        )
        .padding(.bottom, 12)
    }

    @ViewBuilder
    var DescriptionContainer: some View {
        if let description = product.description {
            Text(description)
                .style(size: 17, weight: .regular, color: Constants.textSecondary)
        }
    }

    @ViewBuilder
    func SubtitleInfo(
        imageResource: ImageResource,
        title: String,
        text: String?
    ) -> some View {
        if let text {
            HStack(spacing: 6) {
                Image(imageResource)
                    .frame(width: 12, height: 12)

                Text(title).style(size: 17, weight: .regular, color: Constants.textSecondary)

                Text(text).style(size: 17, weight: .regular, color: Constants.textPrimary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ProductDetailsView(viewModel: .mockData)
}

// MARK: - Constants

private extension ProductDetailsView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textLink = DLColor<TextPalette>.blue.color
        static let textSecondary = DLColor<TextPalette>.gray800.color
        static let textWhite = DLColor<TextPalette>.white.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
    }
}
