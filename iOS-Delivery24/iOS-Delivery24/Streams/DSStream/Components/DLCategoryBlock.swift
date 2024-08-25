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
    struct Configuration {
        var isShimmering = false
        var cells: [CellData] = []

        struct CellData: Identifiable {
            var id: String { title }
            var title: String
            var imageURL: URL?
        }
    }

    let configuration: Configuration
    @State private var width: CGFloat = .zero

    var body: some View {
        MainContainer
    }
}

// MARK: - UI Subviews

private extension DLCategoryBlock {

    var MainContainer: some View {
        LazyVGrid(columns: [
            GridItem(),
            GridItem(),
            GridItem()
        ], spacing: .SPx2) {
            if configuration.isShimmering {
                ShimmeringContainer
            } else {
                MainData
            }
        }
    }

    var ShimmeringContainer: some View {
        ForEach(0..<9, id: \.self) { index in
            ShimmeringView()
                .frame(height: width)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            guard width == .zero else { return }
                            width = geo.size.width
                        }
                    }
                }
        }
    }

    @ViewBuilder
    var MainData: some View {
        ForEach(0..<configuration.cells.count, id: \.self) { index in
            CellView(for: index)
                .frame(height: width)
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            guard width == .zero else { return }
                            width = geo.size.width
                        }
                    }
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
                        .overlay {
                            GeometryReader { geo in
                                Color.clear.onAppear {
                                    guard width == .zero else { return }
                                    width = geo.size.width
                                }
                            }
                        }
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
        configuration: .init(isShimmering: true)
    )
    .padding(.horizontal)
}

#Preview {
    DLCategoryBlock(
        configuration: .init(
            cells: [
                .init(title: "Детское питание", imageURL: .mockURL),
                .init(title: "2", imageURL: .mockURL),
                .init(title: "3", imageURL: .mockURL),
                .init(title: "4", imageURL: .mockURL),
                .init(title: "5", imageURL: .mockURL),
                .init(title: "6", imageURL: .mockURL),
                .init(title: "7", imageURL: .mockURL),
                .init(title: "8", imageURL: .mockURL),
                .init(title: "9", imageURL: .mockURL),
            ]
        )
    )
    .padding(.horizontal)
}
