//
// DLCategoryBlock.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

struct DLCategoryBlock: View {
    @Environment(\.mainWindowSize) var screenSize

    struct Configuration {
        var isShimmering = false
        var cells: [CellData] = []

        struct CellData: Identifiable {
            var id: Int
            var title: String
            var imageURL: URL?
        }
    }

    let configuration: Configuration
    var didSelectIcon: DLIntBlock
    private var width: CGFloat {
        (screenSize.width - .SPx2 * 2 - .SPx4 * 2) / 3
    }

    var body: some View {
        MainContainer
    }
}

// MARK: - UI Subviews
// (width - SPx2 * 2 - SPx4 * 2) / 3
private extension DLCategoryBlock {

    @ViewBuilder
    var MainContainer: some View {
        if configuration.isShimmering {
            ShimmeringContainer
        } else {
            LazyVGrid(columns: [
                GridItem(),
                GridItem(),
                GridItem()
            ], spacing: .SPx2) {
                MainData
            }
        }
    }

    var ShimmeringContainer: some View {
        VStack(spacing: .SPx2) {
            HStack(spacing: .SPx2) {
                ForEach(0..<3) { _ in
                    ShimmeringKind
                }
            }
            HStack(spacing: .SPx2) {
                ForEach(3..<6) { _ in
                    ShimmeringKind
                }
            }
            HStack(spacing: .SPx2) {
                ForEach(6..<9) { _ in
                    ShimmeringKind
                }
            }
        }
    }

    var ShimmeringKind: some View {
        ShimmeringView()
            .frame(height: width)
            .clipShape(.rect(cornerRadius: 20))
    }

    @ViewBuilder
    var MainData: some View {
        ForEach(0..<configuration.cells.count, id: \.self) { index in
            CellView(for: index)
                .frame(height: width)
//                .getWidth(width: $width)
                .onTapGesture {
                    didSelectIcon(configuration.cells[index].id)
                }
        }
    }

    func CellView(for index: Int) -> some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(configuration.cells[index].imageURL)
            )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .fill(DLColor<SeparatorPalette>.grayBorder.color)
        }
        .overlay(alignment: .bottomLeading) {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(
                    colors: [.black, .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .opacity(0.6)

                Text(configuration.cells[index].title)
                    .style(size: 15, weight: .semibold, color: DLColor<TextPalette>.white.color)
                    .padding([.horizontal, .bottom], 12)
            }
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}

// MARK: - Deprecated

private extension DLCategoryBlock {

    @available(*, deprecated, message: "Данный метод используется для 8 категорий")
    @ViewBuilder
    var OldViewWithRectangle: some View {
        HStack {
            ForEach(0..<3) { index in
                if index < configuration.cells.count {
                    CellView(for: index)
                        .frame(height: width)
//                        .getWidth(width: $width)
                }
            }
        }
        HStack {
            ForEach(3..<5) { index in
                if index < configuration.cells.count {
                    if index == 3 {
                        CellView(for: index)
                            .frame(width: width, height: width)
                    } else {
                        CellView(for: index)
                            .frame(height: width)
                    }
                }
            }
        }
        HStack {
            ForEach(5..<8) { index in
                if index < configuration.cells.count {
                    CellView(for: index)
                        .frame(width: width, height: width)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("Shimmering") {
    DLCategoryBlock(
        configuration: .init(
            cells: [
                .init(id: 1, title: "Детское питание", imageURL: .mockURL),
                .init(id: 2, title: "2", imageURL: .mockURL),
                .init(id: 3, title: "3", imageURL: .mockURL),
                .init(id: 4, title: "4", imageURL: .mockURL),
                .init(id: 5, title: "5", imageURL: .mockURL),
                .init(id: 6, title: "6", imageURL: .mockURL),
                .init(id: 7, title: "7", imageURL: .mockURL),
                .init(id: 8, title: "8", imageURL: .mockURL),
                .init(id: 9, title: "9", imageURL: .mockURL),
            ]
        )
    ) { _ in }
        .padding(.horizontal)
        .setScreenSizeForPreview
}

#Preview {
    DLCategoryBlock(
        configuration: .init(
            cells: [
                .init(id: 1, title: "Детское питание", imageURL: .mockURL),
                .init(id: 2, title: "2", imageURL: .mockURL),
                .init(id: 3, title: "3", imageURL: .mockURL),
                .init(id: 4, title: "4", imageURL: .mockURL),
                .init(id: 5, title: "5", imageURL: .mockURL),
                .init(id: 6, title: "6", imageURL: .mockURL),
                .init(id: 7, title: "7", imageURL: .mockURL),
                .init(id: 8, title: "8", imageURL: .mockURL),
                .init(id: 9, title: "9", imageURL: .mockURL),
            ]
        )
    ) { _ in }
        .padding(.horizontal)
        .setScreenSizeForPreview
}
