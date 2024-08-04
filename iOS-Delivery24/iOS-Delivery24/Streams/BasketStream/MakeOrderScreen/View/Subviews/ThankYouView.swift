//
// ThankYouView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct ThankYouView: View {

    var body: some View {
        VStack {
            Text(Constants.title)
                .style(size: 17, weight: .regular, color: DLColor<TextPalette>.primary.color)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Spacer()

            Image(.done)

            Spacer()

            Button {
                // TODO: Открыть экран каталога
            } label: {
                Text(Constants.buttonTitle)
                    .style(size: 16, weight: .semibold, color: .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 22)
            }
            .background(Constants.bgButtonColor, in: .rect(cornerRadius: 12))
            .padding(.horizontal)
        }
        .navigationTitle(Constants.navigationTitle)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        ThankYouView()
    }
}

// MARK: - Constants

private extension ThankYouView {

    enum Constants {
        static let navigationTitle = String(localized: "Спасибо за заказ")
        static let title = String(localized: "Менеджер свяжется с вами в ближайшее время")
        static let buttonTitle = String(localized: "В каталог")
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
    }
}
