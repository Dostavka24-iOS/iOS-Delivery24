//
// DProductCard.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

struct DProductCard: View {

    struct HandlerConfiguration {
        var didTapLike: DLVoidBlock?
        var didTapBasket: DLVoidBlock?
    }

    var product: DProductCardModel
    var handler: HandlerConfiguration?

    var body: some View {
        ProductCardContent
            .background(
                RoundedRectangle(cornerRadius: .CRx5)
                    .fill(.background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: .CRx5)
                    .stroke(Constants.borderColor, lineWidth: 1)
            )
    }
}

extension DProductCard {

    var ProductCardContent: some View {
        VStack(spacing: 0) {
            ImageContainer
                .padding(.bottom, .SPx3)
            ProductInfoBlock
                .padding(.bottom, .SPx2)
            BuyButton
                .padding(.bottom, .SPx3)
        }
    }

    var ImageContainer: some View {
        ProductImage
            .clipShape(CustomShape())
            .overlay(alignment: .topLeading) {
                TagsStack
                    .padding([.top, .leading], .SPx3)
            }
            .overlay(alignment: .topTrailing) {
                LikeButton
                    .padding([.top, .trailing], .SPx3)
            }
    }

    var ProductImage: some View {
        KFImage(product.imageURL)
            .placeholder {
                Rectangle()
                    .fill(.thinMaterial)
            }
            .resizable()
            .scaledToFit()
            .frame(height: 180)
            .frame(maxWidth: .infinity)
    }

    var TagsStack: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ForEach(product.tags, id: \.self) { productTag in
                Text(productTag.rawValue)
                    .font(.system(size: 11))
                    .padding(.horizontal, .SPx1)
                    .padding(.vertical, .SPx0_5)
                    .background(productTag.backgroundColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
        }
    }

    var LikeButton: some View {
        ZStack {
            Circle()
                .fill(.white)

            Button(action: {
                handler?.didTapLike?()
            }, label: {
                Image(.heart)
                    .resizable()
                    .frame(width: 16, height: 16)
            })
        }
        .frame(width: 36, height: 36)
    }

    var ProductInfoBlock: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ProductPrice
            ProductTitle
            Spacer(minLength: 0)
            ProductDescription
        }
        .padding(.horizontal, .SPx2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var ProductPrice: some View {
        Text(product.price)
            .font(.headline)
            .lineLimit(1)
    }
    
    var ProductTitle: some View {
        Text(product.title)
            .font(.system(size: 13))
            .bold()
            .lineLimit(2)
    }

    var ProductDescription: some View {
        Text(product.description)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .lineLimit(1)
    }

    var BuyButton: some View {
        Button(action: {
            handler?.didTapBasket?()
        }) {
            HStack {
                Image(systemName: "plus")
                Text("В корзину")
            }
                .padding(.SPx3)
                .frame(maxWidth: .infinity)
        }
        .background(Constants.buyButtonBackgroundColor)
        .foregroundStyle(.black)
        .cornerRadius(10)
        .padding(.horizontal, .SPx3)
    }
}

#Preview {
    DProductCard(product: {
        .init(
            id: 1,
            imageURL: URL(string: "https://avatars.mds.yandex.net/i?id=f2f6c7de9b79887ad4f3188da5d2ca0e_l-5254684-images-thumbs&n=13"),
            title: "Тут длинное название на две строки",
            price: "99",
            description: "Описание",
            tags: [.promotion, .hit, .exclusive]
        )
    }())
    .frame(width: 167, height: 338)
}

// MARK: - Constants

extension DProductCard {

    enum Constants {
        static let buyButtonBackgroundColor = Color(uiColor: UIColor(rgb: 0xF5F5F5))
        static let borderColor = Color(uiColor: UIColor(rgb: 0xEDEFF1))
    }
}
