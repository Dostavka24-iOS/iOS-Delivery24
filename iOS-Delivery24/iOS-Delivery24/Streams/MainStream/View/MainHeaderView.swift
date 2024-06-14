//
// MainHeaderView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 14.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct MainHeaderView: View {
    @Binding var textInput: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextWithPriceView

            Image(.logo)
                .padding(.top, 15)

            DLSearchField(text: $textInput)
                .padding(.top, 12)
        }
        .padding(.horizontal)
    }
}

// MARK: - UI Subviews

private extension MainHeaderView {

    var TextWithPriceView: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Укажите адрес доставки")
                    .style(size: 11, weight: .semibold, color: Constants.titleColor)

                Image(.bottomChevron)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
            }

            Spacer()

            HStack {
                Image(.money)

                Text("102")
                    .style(size: 11, weight: .semibold, color: Constants.priceColor)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6.5)
            .background(Constants.priceBgColor, in: .rect(cornerRadius: 8))
        }
    }
}

#Preview {
    MainHeaderView(textInput: .constant(""))
}

private extension MainHeaderView {

    enum Constants {
        // FIXME: iOS-3: Заменить на цвета DS
        static let titleColor = Color.primary
        static let priceColor = Color.primary
        static let priceBgColor = Color.yellow
        static let chevronColor = Color.secondary
        // -
    }
}
