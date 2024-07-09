//
// DLProductHCard.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLProductHCard: View {

    let configuration: Configuration

    @State private var counter = 0

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            HStack(spacing: 0) {
                DLImageView(configuration: .init(imageKind: configuration.imageKind))
                    .frame(width: size.width * 0.35)

                VStack(alignment: .leading) {
                    ProductContent

                    Spacer()

                    ButtonsView
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 12)
                }
            }
            .frame(width: size.width, height: size.height)
            .clipShape(.rect(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
                // FIXME: iOS-3: Заменить на цвета ДС
                    .fill()
            }
        }
    }
}

// MARK: - Configuration

extension DLProductHCard {

    struct Configuration {
        var title: String
        var price: String
        var unitPrice: String
        var cornerPrice: String
        var count: String
        var isLiked: Bool
        var imageKind: ImageKind
    }
}

// MARK: - UI Subviews

private extension DLProductHCard {

    var ProductContent: some View {
        // FIXME: iOS-3: Заменить на цвета ДС
        VStack(alignment: .leading, spacing: 4) {
            Text(configuration.price)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(configuration.unitPrice)
                .style(size: 14, weight: .medium, color: .secondary)

            Text(configuration.title)
                .style(size: 14, weight: .semibold, color: .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 12)
    }

    var ButtonsView: some View {
        HStack(spacing: 12) {
            Button(action: {}, label: {
                Image(.trash)
                    .frame(width: 32, height: 32)
                    // FIXME: iOS-3: Заменить цвета ДС
                    .background(Color(uiColor: .lightGray), in: .circle)
            })

            StepperView
        }
    }

    var StepperView: some View {
        HStack(spacing: 12) {
            Button(action: {
                counter -= 1
            }, label: {
                Image(.minus)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
            })

            Text("\(counter)")
                .frame(minWidth: 49)

            Button(action: {
                counter += 1
            }, label: {
                Image(.plus)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
            })
        }
        .padding(.horizontal)
        .frame(height: 43)
        // FIXME: iOS-3: Заменить цвета ДС
        .background(Color(uiColor: .lightGray), in: .rect(cornerRadius: 12))
    }
}

// MARK: - Preview

#Preview {
    DLProductHCard(
        configuration: .init(
            title: "Жвачка \"Лов Из\" Банан/Клубника",
            price: "303 ₽",
            unitPrice: "3.03 ₽/шт",
            cornerPrice: "1.14",
            count: "100",
            isLiked: false,
            imageKind: .image(Image(.bestGirl))
        )
    )
    .frame(height: 174)
    .padding(.horizontal, 8)
}
