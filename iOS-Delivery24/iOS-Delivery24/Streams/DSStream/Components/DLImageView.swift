//
// DLImageView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

struct DLImageView: View {
    let configuration: Configuration
    @State private var isFailed = false

    var body: some View {
        GeometryReader { geo in
            ImageView(size: geo.size)
        }
    }
}

// MARK: - UI Subviews

private extension DLImageView {

    @ViewBuilder
    func ImageView(size: CGSize) -> some View {
        if isFailed {
            NoneImageView
                .frame(width: size.width, height: size.height)
        } else {
            switch configuration.imageKind {
            case .image(let image):
                ImageConfiguratedView(image: image, size: size)
            case .string(let stringURL):
                let url = URL(string: stringURL)
                ImageFromURL(url: url, size: size)
            case .uiImage(let uiImage):
                Image(uiImage: uiImage)
            case .url(let url):
                ImageFromURL(url: url, size: size)
            }
        }
    }

    @ViewBuilder
    func ImageFromURL(url: URL?, size: CGSize) -> some View {
        if let url {
            KFImage(url)
                .placeholder {
                    ShimmeringView()
                        .frame(width: size.width, height: size.height)
                }
                .onFailure { error in
                    isFailed = true
                    Logger.log(kind: .error, message: error)
                }
                .resizable()
                .aspectRatio(contentMode: configuration.contentMode)
                .frame(width: size.width, height: size.height)
                .clipped()
        } else {
            NoneImageView
                .frame(width: size.width, height: size.height)
        }
    }

    func ImageConfiguratedView(image: Image, size: CGSize) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: configuration.contentMode)
            .frame(width: size.width, height: size.height)
            .clipped()
    }

    var NoneImageView: some View {
        Rectangle()
            .fill(.thinMaterial)
    }
}

// MARK: - Preview

#Preview {
    DLImageView(
        configuration: .init(
            imageKind: ImageKind.string("https://avatars.mds.yandex.net/i?id=3c90f42fc3521f36bac3e41685f9258c_l-5238850-images-thumbs&n=13"),
            contentMode: .fill
        )
    )
    .frame(width: 300, height: 400)
}

// MARK: - Configuration

extension DLImageView {

    struct Configuration {
        var imageKind: ImageKind
        var contentMode: SwiftUI.ContentMode = .fill
    }
}
