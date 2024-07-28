//
// DLProductsCarousel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLProductsCarousel: View {
    struct Configuration {
        var title: String = ""
        var images: [UIImage] = []
    }

    var configuration: Configuration

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(configuration.title)
                    .style(size: 17, weight: .semibold, color: DLColor<TextPalette>.primary.color)

                Spacer()

                Image(.chivronRight)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 9)
                    .foregroundStyle(DLColor<IconPalette>.secondary.color)
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(configuration.images, id: \.cgImage) { uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 100)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                }
                .padding(.horizontal)
            }

            Divider()
                .padding(.top, 15)
                .padding(.leading)
        }
    }
}

#Preview {
    DLProductsCarousel(
        configuration: .init(
            title: "6 товаров",
            images: [
                UIImage(resource: .bestGirl),
                UIImage(resource: .bestGirl),
                UIImage(resource: .bestGirl)
            ]
        )
    )
}
