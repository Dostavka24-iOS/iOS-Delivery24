//
// MyDataSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MyDataScreen {

    var MainBlock: some View {
        VStack(alignment: .leading, spacing: 16) {
            MainInfoBlock

            PhoneSection
        }
        .padding(.horizontal)
    }

    var MainInfoBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Основная информация ")
                .style(size: 28, weight: .bold, color: Constants.primaryColor)

            EmailBlock
        }
    }

    var EmailBlock: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(Constants.emailTitle)
                    .style(size: 13, weight: .semibold, color: Constants.primaryColor)

                TextField(text: $viewModel.uiProperties.emailInput) {
                    Text("Enter the email")
                }
                .padding(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Constants.seaparatorColor)
                }

                Text("Запросить код")
                    .style(size: 13, weight: .regular, color: Constants.blueTextColor)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 0) {
                    TextField(text: $viewModel.uiProperties.passwordInput) {
                        Text("******")
                    }
                    .padding(.leading, 12)

                    Button {
                        
                    } label: {
                        Text("Подтвердить")
                            .style(size: 13, weight: .medium, color: Constants.secondaryColor)
                            .padding(.vertical, 13)
                            .padding(.horizontal, 10)
                    }
                    .background(DLColor<BackgroundPalette>.gray300.color)
                }
                .clipShape(.rect(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Constants.seaparatorColor)
                }

                Text("Введите код, полученный при регистрации, или перейдите поссылке из письма")
                    .style(size: 13, weight: .regular, color: Constants.gray800Color)
                    .padding(.top, 8)
            }
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 24)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(DLColor<SeparatorPalette>.orange.color)
        }
    }

    var PhoneSection: some View {
        VStack(spacing: 24) {
            PhoneBlock
        }
    }

    var PhoneBlock: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Телефон")
                    .style(size: 13, weight: .semibold, color: Constants.primaryColor)

                TextField(text: $viewModel.uiProperties.phoneInput) {
                    Text("+7")
                }
                .padding(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Constants.seaparatorColor)
                }

                HStack {
                    Text("Получить звонок")
                        .style(size: 13, weight: .regular, color: Constants.blueTextColor)
                    Spacer()
                    Text("Запросить код")
                        .style(size: 13, weight: .regular, color: Constants.blueTextColor)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 0) {
                    TextField(text: $viewModel.uiProperties.confirmationСodeInput) {
                        Text("******")
                    }
                    .padding(.leading, 12)

                    Button {

                    } label: {
                        Text("Подтвердить")
                            .style(size: 13, weight: .medium, color: Constants.secondaryColor)
                            .padding(.vertical, 13)
                            .padding(.horizontal, 10)
                    }
                    .background(DLColor<BackgroundPalette>.gray300.color)
                }
                .clipShape(.rect(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(Constants.seaparatorColor)
                }

                Text("На номер телефона +7(906)714-73-10 поступит звонок. Для подтверждения телефона введите последние 4 цифры входящего номера телефона")
                    .style(size: 13, weight: .regular, color: Constants.gray800Color)
            }
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 24)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(Constants.seaparatorGreenColor)
        }
        .padding(.top, 24)
    }
}

// MARK: - Preview

#Preview {
    MyDataScreen()
}

// MARK: - Constants

private extension MyDataScreen {

    enum Constants {
        static let emailTitle = String(localized: "E-mail")
        static let primaryColor = DLColor<TextPalette>.primary.color
        static let secondaryColor = DLColor<TextPalette>.secondary.color
        static let gray800Color = DLColor<TextPalette>.gray800.color
        static let blueTextColor = DLColor<TextPalette>.blue.color
        static let seaparatorColor = DLColor<SeparatorPalette>.gray300.color
        static let seaparatorGreenColor = DLColor<SeparatorPalette>.green.color
    }
}
