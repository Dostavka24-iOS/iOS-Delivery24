//
// DLBasketMakeOrderButton.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLBasketMakeOrderButton: View {
    struct Configuration {
        var title: String
        var subtitle: String
        var isDisable: Bool
    }

    var configuration: Configuration
    var didTapButton: DLVoidBlock?

    var body: some View {
        Button {
            didTapButton?()
        } label: {
            VStack(spacing: 2) {
                Text(configuration.title)
                    .style(size: 16, weight: .semibold, color: Constants.textColor)

                Text(configuration.subtitle)
                    .style(size: 13, weight: .semibold, color: Constants.textColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
        .background(
            !configuration.isDisable ? Constants.bgButtonColor : Constants.bgDisableButtonColor,
            in: .rect(cornerRadius: 12)
        )
        .disabled(configuration.isDisable)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 30) {
        DLBasketMakeOrderButton(
            configuration: .init(
                title: "title",
                subtitle: "subtitle",
                isDisable: false
            )
        )

        Divider()

        DLBasketMakeOrderButton(
            configuration: .init(
                title: "title",
                subtitle: "subtitle",
                isDisable: true
            )
        )
    }
    .padding(.horizontal, 12)
}

// MARK: - Constants

private extension DLBasketMakeOrderButton {

    enum Constants {
        static let textColor = DLColor<TextPalette>.white.color
        static let primaryTextColor = DLColor<TextPalette>.primary.color
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
        static let bgDisableButtonColor = DLColor<BackgroundPalette>.lightGray2.color
        static let iconColor = DLColor<IconPalette>.primary.color
    }
}
