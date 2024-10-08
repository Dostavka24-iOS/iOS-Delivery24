//
// DLMinimumOrderSumView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLMinimumOrderSumView: View {
    var needPrice: String
    var total: String
    var isReady: Bool
    var minimumSum: String
    @Binding var isOpened: Bool

    var didTapMakeOrderButton: DLVoidBlock

    var body: some View {
        MainView
    }
}

// MARK: - UI Subviews

private extension DLMinimumOrderSumView {

    @ViewBuilder
    var MainView: some View {
        if isReady {
            MakeOrderButton
        } else {
            ZStack(alignment: .bottom) {
                DLColor<BackgroundPalette>.overlay.color.opacity(isOpened ? 1 : 0)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            isOpened = false
                        }
                    }

                OrderDontReady
                    .padding(.top)
                    .background(DLColor<BackgroundPalette>.white.color)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
    }

    var OrderDontReady: some View {
        VStack(spacing: 16) {
            HStack(spacing: 0) {
                Spacer()
                Text("Еще \(needPrice) до минимального заказа")
                    .style(size: 11, weight: .semibold, color: DLColor<TextPalette>.primary.color)

                Spacer()

                if isOpened {
                    Button {
                        withAnimation(.snappy) {
                            isOpened = false
                        }
                    } label: {
                        Image(.xmark)
                            .renderingMode(.template)
                            .foregroundStyle(Constants.iconColor)
                            .frame(width: 16, height: 16)
                    }
                } else {
                    Image(.chivronRight)
                        .renderingMode(.template)
                        .foregroundStyle(Constants.iconColor)
                        .frame(width: 16, height: 16)
                }
            }
            .padding(.horizontal)
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(.snappy) {
                    isOpened = true
                }
            }

            if isOpened {
                InfoMinimumSumView
            } else {
                MakeOrderButton
            }
        }
    }

    var MakeOrderButton: some View {
        DLButton(
            configuration: .init(
                hasDisabled: !isReady,
                titleView: {
                    Text("К оформлению")
                        .style(size: 16, weight: .semibold, color: Constants.textColor)
                },
                subtileView: {
                    Text("Итого: \(total)")
                        .style(size: 13, weight: .semibold, color: Constants.textColor)
                }
            ),
            action: didTapMakeOrderButton
        )
        .padding(.horizontal, 12)
        .padding(.bottom)
    }

    var InfoMinimumSumView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Минимальная сумма заказа \(minimumSum)")
                .style(size: 17, weight: .semibold, color: Constants.primaryTextColor)

            Text("Извините, но общая сумма вашего заказа должна быть больше минимальной суммы заказа ")
                .style(size: 14, weight: .regular, color: Constants.primaryTextColor)
        }
        .padding(.horizontal)
        .padding(.bottom, 48)
    }
}

// MARK: - Preview

#Preview {
    DLMinimumOrderSumView(
        needPrice: "4 210.4 ₽",
        total: "2 789.60 ₽",
        isReady: false,
        minimumSum: "7 000 ₽",
        isOpened: .constant(true)
    ) {}.ignoresSafeArea()
}

#Preview {
    VStack(spacing: 30) {
        DLMinimumOrderSumView(
            needPrice: "4 210.4 ₽",
            total: "2 789.60 ₽",
            isReady: true,
            minimumSum: "7 000 ₽",
            isOpened: .constant(false)
        ) {}

        Divider()

        DLMinimumOrderSumView(
            needPrice: "4 210.4 ₽",
            total: "2 789.60 ₽",
            isReady: false,
            minimumSum: "7 000 ₽",
            isOpened: .constant(false)
        ) {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray)
}

// MARK: - Constants

private extension DLMinimumOrderSumView {

    enum Constants {
        static let textColor = DLColor<TextPalette>.white.color
        static let primaryTextColor = DLColor<TextPalette>.primary.color
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
        static let bgDisableButtonColor = DLColor<BackgroundPalette>.lightGray2.color
        static let iconColor = DLColor<IconPalette>.primary.color
    }
}
