//
// DBanner.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 24.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DBanners: View {

    var imageUrls: [URL?]

    var body: some View {
        LazyHStack {
            TabView {
                ForEach(imageUrls.indices, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(.secondary)

                        AsyncImage(url: imageUrls[index]) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                            case .failure:
                                ProgressView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                .padding(.horizontal)
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

#Preview {
    DBanners(imageUrls: .mock)
        .frame(height: 180)
}

// TODO: Удалить потом

extension [URL?] {

    static let mock = [
        URL(string: "https://www.dostavka24.net/upload/banners/7593918_1110kh460jpg.jpg"),
        URL(string: "https://www.dostavka24.net/upload/banners/4572681_cc-buy-1110x460-v3jpg.jpg"),
        URL(string: "https://www.dostavka24.net/upload/banners/7593918_1110kh460jpg.jpg"),
        URL(string: "https://www.dostavka24.net/upload/banners/4572681_cc-buy-1110x460-v3jpg.jpg"),
    ]
}
