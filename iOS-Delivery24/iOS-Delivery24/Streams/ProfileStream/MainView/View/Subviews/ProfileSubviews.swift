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

    @ViewBuilder
    var MainBlock: some View {
        if viewModel.needAuth {
            NeedAuthContainerView
        } else {
            UserIsAuthedView
        }
    }

    var NeedAuthContainerView: some View {
        DontResultView(
            configuration: .init(
                resource: Constants.emptyImage,
                title: Constants.emptyViewTitle,
                subtitle: Constants.emptyViewSubtitle
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            VStack(spacing: 0) {
                DLButton(
                    configuration: .init(
                        titleView: {
                            Text("Регистарция")
                                .style(size: 16, weight: .semibold, color: DLColor<TextPalette>.white.color)
                        }
                    ),
                    action: viewModel.didTapRegistration
                )
                .padding(.top, 81)
                .padding(.horizontal)

                HStack(spacing: 3) {
                    Text("Уже есть аккаунт?")
                        .style(size: 13, weight: .regular, color: Constants.textColor)

                    Button(action: viewModel.didTapSignIn, label: {
                        Text("Войти")
                            .style(size: 13, weight: .regular, color: Constants.textBlue)
                    })
                }
                .padding(.top, 32)
            }
            .padding(.bottom, 60)
        }
    }

    var UserIsAuthedView: some View {
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
                RowInfo(row: row) {
                    viewModel.didTapRowTitle(row: row)
                }
                .overlay(alignment: .bottom) {
                    Divider().padding(.leading)
                }
            }
        }
    }

    @ViewBuilder
    func RowInfo(
        row: ViewModel.Rows,
        didTapRowTitle: @escaping DLVoidBlock
    ) -> some View {
        switch row {
        case .favorites:
            FavoriteRowView(
                title: row.locolizedString,
                icon: row.icon,
                didTapTitle: didTapRowTitle
            ) { product in
                viewModel.didTapProduct(product: product)
            }
        case .userData,
                .address,
                .orders,
                .telegramBot,
                .info,
                .feedback:
            RowTitleView(
                title: row.locolizedString,
                icon: row.icon,
                didTapRowTitle: didTapRowTitle
            )
            .padding(.horizontal)
        case .faq, .quit:
            RowTitleView(
                title: row.locolizedString,
                icon: row.icon,
                didTapRowTitle: didTapRowTitle
            )
            .padding(.horizontal)
            .padding(.top, 32)
        }
    }

    func RowTitleView(
        title: String,
        icon: Image,
        didTapRowTitle: @escaping DLVoidBlock
    ) -> some View {
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
        .contentShape(.rect)
        .onTapGesture {
            didTapRowTitle()
        }
    }

    func FavoriteRowView(
        title: String,
        icon: Image,
        didTapTitle: @escaping DLVoidBlock,
        didTapProduct: @escaping DLGenericBlock<ProductEntity>
    ) -> some View {
        VStack(spacing: 0) {
            RowTitleView(
                title: title,
                icon: icon,
                didTapRowTitle: didTapTitle
            )
            .padding(.horizontal)

            if !viewModel.data.favoriteProducts.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 8) {
                        ForEach(viewModel.data.favoriteProducts, id: \.id) { product in
                            if let productModel = product.mapper {
                                ProductImage(product: productModel).onTapGesture {
                                    didTapProduct(product)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
    }

    @ViewBuilder
    func ProductImage(product: MainViewModel.Product) -> some View {
        if let url = URL(string: product.imageURL) {
            DLImageView(
                configuration: .init(
                    imageKind: .url(url),
                    contentMode: .fit
                )
            )
            .frame(width: 75, height: 100)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
    }
}

// MARK: - Preview

#Preview("Mock Data") {
    ProfileScreen(viewModel: .mockData)
}

#Preview {
    ProfileScreen()
}

// MARK: - Constants

private extension ProfileScreen {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
        static let textBlue = DLColor<TextPalette>.darkBlue.color
        static let iconColor = DLColor<IconPalette>.gray800.color
        static let iconSecondaryColor = DLColor<IconPalette>(
            hexLight: 0x3C3C434D,
            hexDark: 0x3C3C434D,
            alpha: 0.3
        ).color
        static let navigationTitle = String(localized: "Профиль")
        static let emptyImage = ImageResource.profile
        static let emptyViewTitle = "Здесь будут все данные о ваших заказах"
        static let emptyViewSubtitle = "Мотивирующий текст"
    }
}
