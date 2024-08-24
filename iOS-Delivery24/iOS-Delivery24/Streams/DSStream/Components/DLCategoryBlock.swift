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
        var cells: [CellData] = []

        struct CellData: Identifiable {
            var id: String { title }
            var title: String
            var imageURL: URL?
        }
    }

    let configuration: Configuration
    @State private var count = 0
    @State private var width: CGFloat = .zero

    var body: some View {
        VStack {
            HStack {
                ForEach(0..<3) { index in
                    if index < configuration.cells.count {
                        cellView(for: index)
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
                            cellView(for: index)
                                .frame(width: width)
                        } else {
                            cellView(for: index)
                        }
                    }
                }
            }
            HStack {
                ForEach(5..<8) { index in
                    if index < configuration.cells.count {
                        cellView(for: index)
                    }
                }
            }
        }
        .onAppear {
            count = configuration.cells.count
        }
    }

    private func cellView(for index: Int) -> some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(
                    configuration.cells[index].imageURL
                )
            )
        )
        .clipShape(.rect(cornerRadius: 20))
    }
}

// MARK: - Preview

#Preview {
    DLCategoryBlock(
        configuration: .init(
            cells: [
                .init(title: "1", imageURL: .mockURL),
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
    .frame(height: 343)
    .padding(.horizontal)
}
