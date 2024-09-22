//
// DLPhoneNumberTextField.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 22.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct PhoneNumberTextField: View {
    @Binding var phoneNumber: String

    var body: some View {
        HStack(spacing: .SPx2) {
            HStack(spacing: .SPx2) {
                Image(.rusFlag)
                    .frame(width: 20, height: 20)
                Text("+7")
                    .style(size: 17, weight: .regular, color: DLColor<TextPalette>.primary.color)
            }
            .padding(12)
            .frame(height: 44)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(DLColor<SeparatorPalette>.gray.color, lineWidth: 1)
            }

            TextField(text: $phoneNumber, prompt: Text("(000) 000 00 00")) {
                Text(phoneNumber)
                    .style(size: 17, weight: .regular, color: DLColor<TextPalette>.primary.color)
            }
            .frame(height: 20)
            .keyboardType(.numberPad)
            .onChange(of: phoneNumber) { newValue in
                phoneNumber = formatPhoneNumber(phoneNumber: phoneNumber)
            }
            .padding(12)
            .frame(height: 44)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(DLColor<SeparatorPalette>.gray.color, lineWidth: 1)
            }
        }
    }

    private func formatPhoneNumber(phoneNumber: String) -> String {
        let digits = phoneNumber.filter { $0.isNumber }
        var formatted = String(digits.prefix(10))
        if formatted.count >= 1 {
            formatted.insert(contentsOf: "(", at: formatted.startIndex)
        }
        if formatted.count > 7 {
            formatted.insert(contentsOf: " ", at: formatted.index(formatted.startIndex, offsetBy: 7))
        }
        if formatted.count > 4 {
            formatted.insert(contentsOf: " ", at: formatted.index(formatted.startIndex, offsetBy: 4))
        }
        if formatted.count > 11 {
            formatted.insert(contentsOf: " ", at: formatted.index(formatted.startIndex, offsetBy: 11))
        }
        if formatted.count > 4 {
            formatted.insert(contentsOf: ")", at: formatted.index(formatted.startIndex, offsetBy: 4))
        }
        return formatted
    }
}

// MARK: - Preview

#Preview {
    PhoneNumberTextField(phoneNumber: .constant(""))
        .padding(.horizontal)
}
