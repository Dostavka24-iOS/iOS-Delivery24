//
// DBanner.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 24.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

struct BannerPage: Identifiable, Equatable {
    var id: Int
    var url: URL?
}

struct DBanners: View {

    @State var pages: [BannerPage] = []
    @State private var fakePages: [BannerPage] = []
    @State private var currentPage: Int = 0

    var body: some View {
        GeometryReader {
            let size = $0.size

            TabView(selection: $currentPage) {
                ForEach(fakePages) { page in
                    CarouselItem(page.url)
                        .tag(page.id)
                        .offsetX(currentPage == page.id) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndexOf(page)))

                            let pageProgress = pageOffset / size.width

                            if -pageProgress < 1.0 {
                                if fakePages.indices.contains(fakePages.count - 1) {
                                    currentPage = fakePages[fakePages.count - 1].id
                                }
                            }

                            if -pageProgress > CGFloat(fakePages.count - 1) {
                                if fakePages.indices.contains(1) {
                                    currentPage = fakePages[1].id
                                }
                            }
                        }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: size.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            guard fakePages.isEmpty else { return }
            fakePages.append(contentsOf: pages)

            if var firstImage = pages.first, var lastImage = pages.last {
                currentPage = firstImage.id

                firstImage.id = .init()
                lastImage.id = .init()

                fakePages.append(firstImage)
                fakePages.insert(lastImage, at: 0)
            }
        }
    }

    func fakeIndexOf(_ page: BannerPage) -> Int {
        fakePages.firstIndex { $0 == page } ?? 0
    }
}

extension DBanners {

    func CarouselItem(_ url: URL?) -> some View {
        ZStack {
            Rectangle()
                .fill(.thinMaterial)

            KFImage(url)
                .resizable()
                .placeholder{
                    ProgressView()
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .padding(.horizontal)
    }
}

extension [URL?] {

    static let mock = [
        URL(string: "https://www.dostavka24.net/upload/banners/7593918_1110kh460jpg.jpg"),
        URL(string: "https://www.dostavka24.net/upload/banners/4572681_cc-buy-1110x460-v3jpg.jpg"),
        URL(string: "https://www.dostavka24.net/upload/banners/7593918_1110kh460jpg.jpg"),
        URL(string: "https://www.dostavka24.net/upload/banners/4572681_cc-buy-1110x460-v3jpg.jpg"),
    ]
}
