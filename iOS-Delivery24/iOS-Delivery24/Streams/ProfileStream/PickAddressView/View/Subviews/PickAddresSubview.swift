//
// PickAddresSubview.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension PickAddressView {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.data.addreses) { address in
                    AddressCellView(address: address)
                }

                AddNewAddressButton
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.navigationTitle)
    }

    func AddressCellView(address: ViewModel.AddressInfo) -> some View {
        Button(action: {
            guard
                viewModel.uiProperties.selectedAddress != address
            else { return }
            viewModel.didPickAddress(address: address)
        }, label: {
            HStack(spacing: 16) {
                DLCheckbox(
                    configuration: .init(
                        isSelected: viewModel.uiProperties.selectedAddress == address
                    )
                ) { isSelected in
                    guard isSelected else { return }
                    viewModel.didPickAddress(address: address)
                }

                Text(address.locationTitle)
                    .style(size: 17, weight: .regular, color: Constants.textColor)

                Spacer()
            }
        })
        .padding(.vertical, 17)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }

    var AddNewAddressButton: some View {
        Button {
            viewModel.didTapAddNewAddress()
        } label: {}
        .buttonStyle(CustomButton())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 5)
    }
}

// MARK: - Helper

private extension PickAddressView {

    struct CustomButton: ButtonStyle {

        func makeBody(configuration: Configuration) -> some View {
            HStack(spacing: 16) {
                Image(.plus)

                Text("Добавить")
                    .style(size: 17, weight: .regular, color: Constants.textColor)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(
                configuration.isPressed
                ? DLColor<BackgroundPalette>.lightGray.color
                : .clear,
                in: .capsule
            )
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        PickAddressView(viewModel: .mockData)
    }
}

// MARK: - Constants

private extension PickAddressView {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
        static let navigationTitle = String(localized: "Адреса доставки")
    }
}
