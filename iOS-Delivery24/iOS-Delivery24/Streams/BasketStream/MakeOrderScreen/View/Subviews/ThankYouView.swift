//
// ThankYouView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct ThankYouView: View {
    @EnvironmentObject private var mainVM: MainViewModel
    @EnvironmentObject private var nav: Navigation

    var body: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            Text(Constants.navigationTitle)
                .style(size: 34, weight: .bold, color: Constants.textPrimary)

            Text(Constants.title)
                .style(size: 17, weight: .regular, color: Constants.textPrimary)

            Spacer()

            DLButton(configuration: .init(
                hasDisabled: false,
                titleView: {
                    Text(Constants.buttonTitle)
                        .style(size: 16, weight: .semibold, color: Constants.textWhite)
                }
            )) {
                mainVM.uiProperties.tabItem = .catalog
                nav.goToRoot()
            }
        }
        .padding(.top, 3)
        .padding(.horizontal)
        .overlay {
            Image(.done)
        }
    }
}

// MARK: - Preview

#Preview {
    ThankYouView()
        .environmentObject(Navigation())
        .environmentObject(MainViewModel())
}

// MARK: - Constants

private extension ThankYouView {

    enum Constants {
        static let navigationTitle = String(localized: "Спасибо за заказ")
        static let title = String(localized: "Менеджер свяжется с вами в ближайшее время")
        static let buttonTitle = String(localized: "В каталог")
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
        static let textWhite = DLColor<TextPalette>.white.color
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
