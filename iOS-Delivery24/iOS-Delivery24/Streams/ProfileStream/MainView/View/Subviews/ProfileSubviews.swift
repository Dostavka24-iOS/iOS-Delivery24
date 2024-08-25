//
// ProfileSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

extension ProfileScreen {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 16) {
                NotificationBlock

                SectionsBlock
            }
        }
        .navigationTitle(Constants.navigationTitle)
    }

    var NotificationBlock: some View {
        VStack {
            ForEach(viewModel.data.notifications) { notification in
                DLNotification(text: notification.text)
                    .padding(.horizontal)
            }
        }
    }

    var SectionsBlock: some View {
        VStack(spacing: 0) {
            ForEach(ViewModel.Rows.allCases) { row in
                RowInfo(row: row).overlay(alignment: .bottom) {
                    Divider().padding(.leading)
                }
            }
        }
    }

    @ViewBuilder
    func RowInfo(row: ViewModel.Rows) -> some View {
        switch row {
        case .favorites:
            FavoriteRowView(title: row.locolizedString, icon: row.icon)
        case .userData,
                .address,
                .orders,
                .telegramBot,
                .info,
                .feedback:
            RowTitleView(title: row.locolizedString, icon: row.icon)
                .padding(.horizontal)
        case .faq, .quit:
            RowTitleView(title: row.locolizedString, icon: row.icon)
                .padding(.horizontal)
                .padding(.top, 32)
        }
    }

    func RowTitleView(title: String, icon: Image) -> some View {
        HStack(spacing: 0) {
            icon
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundStyle(Constants.iconColor)

            Text(title.capitalizingFirstLetter)
                .style(size: 17, weight: .regular, color: Constants.textColor)
                .padding(.leading, 8)

            Spacer()

            Image(.chivronRight)
                .renderingMode(.template)
                .frame(width: 44, height: 44)
                .foregroundStyle(Constants.iconSecondaryColor)
        }
    }

    func FavoriteRowView(title: String, icon: Image) -> some View {
        VStack(spacing: 0) {
            RowTitleView(title: title, icon: icon)
                .padding(.horizontal)

            if !viewModel.data.favoriteProducts.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 8) {
                        ForEach(viewModel.data.favoriteProducts) { product in
                            ProductImage(product: product)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
    }

    func ProductImage(product: MainViewModel.Product) -> some View {
        KFImage(URL(string: product.imageURL))
            .placeholder {
                Image(.productMock)
                    .resizable()
                    .frame(height: 180)
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 100)
            .background(
                Color(
                    uiColor: UIColor(
                        red: 242,
                        green: 242,
                        blue: 242
                    )
                )
            )
            .clipShape(.rect(cornerRadius: 20))
    }
}

// MARK: - Preview

#Preview {
    ProfileScreen(viewModel: .mockData)
}

// MARK: - Constants

private extension ProfileScreen {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
        static let iconColor = DLColor<IconPalette>.gray800.color
        static let iconSecondaryColor = DLColor<IconPalette>(
            hexLight: 0x3C3C434D,
            hexDark: 0x3C3C434D,
            alpha: 0.3
        ).color
        static let navigationTitle = String(localized: "Профиль")
    }
}
