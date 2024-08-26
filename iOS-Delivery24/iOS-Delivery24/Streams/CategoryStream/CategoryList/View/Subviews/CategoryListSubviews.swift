//
// CategoryListSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension CategoryListView {

    var MainContainer: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.rows, id: \.id) { category in
                    if let title = category.title {
                        Button {
                            viewModel.didTapCell(category: category)
                        } label: {
                            CellView(title: title)
                        }
                        .overlay(alignment: .bottom) {
                            Divider()
                        }
                    }
                }
            }
            .padding(.leading)
            .padding(.top, .SPx6)
        }
        .searchable(
            text: $viewModel.uiProperties.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .navigationTitle(viewModel.data.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    func CellView(title: String) -> some View {
        HStack(spacing: .SPx4) {
            Text(title)
                .style(size: 17, weight: .regular, color: Constants.textPrimary)
            Spacer()
            Image(.chivronRight)
                .renderingMode(.template)
                .foregroundStyle(Constants.chivronColor)
                .frame(width: 44, height: 44)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        CategoryListView(viewModel: .mockData)
    }
    .environmentObject(Navigation())
}

// MARK: - Constants

private extension CategoryListView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let chivronColor = DLColor<IconPalette>.secondary.color
    }
}
