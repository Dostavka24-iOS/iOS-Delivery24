//
// MakeOrderSubview.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MakeOrderView {

    var MainBlock: some View {
        ScrollView {
            VStack {
                ImagesBlock

                OptionsBlock
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .overlay(alignment: .bottom) {
            OverlayButton
        }
    }

    var ImagesBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.resultData.deliveryDate)
                .style(size: 13, weight: .regular, color: Constants.textSecondary)
                .padding(.leading)

            DLProductsCarousel(
                configuration: .init(
                    title: "\(viewModel.resultData.images.count) товаров",
                    images: viewModel.resultData.images
                )
            )
        }
    }

    var OptionsBlock: some View {
        VStack {
            PaymentMethodView

            BonusPaymentView

            ResultView
        }
        .padding(.horizontal)
    }

    var PaymentMethodView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Constants.paymentMethodTitle)
                .style(size: 17, weight: .semibold, color: Constants.textPrimary)

            HStack {
                Text("Выставить счёт")
                Spacer()
                Image(.chivronBottom)
                    .frame(width: 20, height: 20)
            }
            .padding([.vertical, .horizontal], 12)
            .background(Constants.bgWhite, in: .rect(cornerRadius: 12))
        }
        .padding()
        .background(Constants.bgGray, in: .rect(cornerRadius: 16))
    }

    var BonusPaymentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(Constants.paymentMethodTitle)
                        .style(size: 17, weight: .semibold, color: Constants.textPrimary)

                    Text(Constants.paymentMethodSubtitle)
                        .style(size: 17, weight: .regular, color: Constants.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .layoutPriority(1)

                Toggle(isOn: $viewModel.uiProperties.bonusesIncluded) {}
                    .labelsHidden()
            }

            if viewModel.bonusesIncluded {
                HStack {
                    TextField("0", text: $viewModel.uiProperties.bonusesCount)
                        .textFieldStyle(.plain)
                        .keyboardType(.numberPad)

                    Button(action: viewModel.didTapApplyBonuses, label: {
                        Text("Применить")
                            .style(size: 13, weight: .semibold, color: Constants.textDarkBlue)
                    })
                }
                .padding(12)
                .background(.white, in: .rect(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(DLColor<SeparatorPalette>.gray.color)
                }
            }
        }
        .padding()
        .background(Constants.bgGray, in: .rect(cornerRadius: 16))
    }

    var ResultView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(Constants.сashbackTitle)
                    .style(size: 13, weight: .regular, color: Constants.textPrimary)

                Spacer()

                Text(viewModel.resultData.cashback)
                    .style(size: 14, weight: .semibold, color: Constants.textPrimary)
            }

            if let bonuses = viewModel.resultData.bonusesCount, viewModel.bonusesIncluded {
                HStack {
                    Text(Constants.bonusesTitle)
                        .style(size: 13, weight: .regular, color: Constants.textPrimary)

                    Spacer()

                    Text(bonuses)
                        .style(size: 14, weight: .semibold, color: Constants.textPrimary)
                }
            }

            HStack {
                Text(Constants.deliveryTitle)
                    .style(size: 13, weight: .regular, color: Constants.textPrimary)

                Spacer()

                Text(viewModel.resultData.deliveryPrice)
                    .style(size: 14, weight: .semibold, color: Constants.textSuccess)
            }

            HStack {
                Text("Итого")
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)

                Spacer()

                Text(viewModel.resultData.resultSum)
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)
            }
        }
        .padding()
        .background(Constants.bgGray, in: .rect(cornerRadius: 16))
        .padding(.bottom, 100)
    }

    var OverlayButton: some View {
        DLBasketMakeOrderButton(
            configuration: .init(
                title: Constants.makeOrderTitle,
                subtitle: "\(Constants.resultTitle) \(viewModel.resultData.resultSum)",
                isDisable: false
            ),
            didTapButton: viewModel.didTapMakeOrder
        )
        .padding(.horizontal, 12)
        .padding(.vertical)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        MakeOrderView(viewModel: .mockData)
    }
}

// MARK: - Constants

private extension MakeOrderView {

    enum Constants {
        static let navigationTitle = String(localized: "Оформление заказа")
        static let bonusPaymenTitle = String(localized: "Оплатить бонусами")
        static let paymentMethodTitle = String(localized: "Способ оплаты")
        static let paymentMethodSubtitle = String(localized: "Оплата бонусами возможна суммами кратным 100")
        static let сashbackTitle = String(localized: "Кэшбэк")
        static let bonusesTitle = String(localized: "Бонусы")
        static let deliveryTitle = String(localized: "Доставка")
        static let makeOrderTitle = String(localized: "Оформить заказ")
        static let resultTitle = String(localized: "Итого")

        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textSecondary = DLColor<TextPalette>.gray300.color
        static let textDarkBlue = DLColor<TextPalette>.darkBlue.color
        static let textSuccess = DLColor<TextPalette>.success.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
        static let bgGray = DLColor<BackgroundPalette>.lightGray3.color
    }
}
