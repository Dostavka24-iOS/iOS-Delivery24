//
// DBanner.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 24.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

struct DBanners: View {

    var imageUrls: [URL?]
    @State private var currentIndex = 1

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentIndex) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(.secondary)

                        KFImage(imageUrls[index % imageUrls.count])
                            .resizable()
                            .placeholder{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .padding(.horizontal)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                DispatchQueue.main.async {
                    currentIndex = 1
                }
            }
            .onChange(of: currentIndex) { newValue in
                if newValue == imageUrls.indices.last {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        currentIndex = 1
                    }
                } else if newValue == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        guard let last = imageUrls.indices.last else { return }
                        currentIndex = last
                    }
                }
            }
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
