//
// MainHeaderView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 14.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MainHeaderView {

    struct Handler {
        var didTapWallet: DLVoidBlock?
        var didTapSelectAddress: DLVoidBlock?
    }
}

struct MainHeaderView: View {
    @Binding var textInput: String
    var moneyCount: String?
    var handler = Handler()

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
            Button {
                handler.didTapSelectAddress?()
            } label: {
                AddressView
            }

            Spacer()

            if let moneyCount {
                Button {
                    handler.didTapWallet?()
                } label: {
                    WalletView(moneyCount: moneyCount)
                }
            }
        }
    }

    var AddressView: some View {
        HStack(spacing: 4) {
            Text(Constants.addressTitle)
                .style(size: 11, weight: .semibold, color: Constants.textPrimary)

            Image(.bottomChevron)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12, height: 12)
        }
    }
}

#Preview {
    MainHeaderView(textInput: .constant(""), moneyCount: "102")
}

private extension MainHeaderView {

    enum Constants {
        static let addressTitle = String(localized: "specify_the_delivery_address").capitalizingFirstLetter
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let priceBgColor = DLColor<BackgroundPalette>.yellow.color
        static let chevronColor = DLColor<IconPalette>.gray800.color
    }
}
