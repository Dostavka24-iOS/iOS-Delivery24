//
// DLImageView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLImageView: View {
    let configuration: Configuration

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

    @ViewBuilder
    func ImageFromURL(url: URL?, size: CGSize) -> some View {
        if let url {
            AsyncImage(url: url, scale: 1) { img in
                ImageConfiguratedView(image: img, size: size)
            } placeholder: {
                PlaceholderView
            }
        } else {
            NoneImageView
        }
    }

    func ImageConfiguratedView(image: Image, size: CGSize) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: configuration.contentMode)
            .frame(width: size.width, height: size.height)
            .clipped()
    }

    var PlaceholderView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var NoneImageView: some View {
        PlaceholderView
    }
}

// MARK: - Preview

#Preview {
    DLImageView(
        configuration: .init(
            imageKind: .string(
                "https://f.vividscreen.info/soft/404d9e6c16fe1a0fbd4a1b1a30cd946f/Anime-Kiss-2560x1600.jpg"
            ),
            contentMode: .fill
        )
    )
    .frame(width: 300, height: 400)
}

// MARK: - Configuration

extension DLImageView {

    struct Configuration {
        var imageKind: ImageKind
        var contentMode: ContentMode = .fill
    }
}
