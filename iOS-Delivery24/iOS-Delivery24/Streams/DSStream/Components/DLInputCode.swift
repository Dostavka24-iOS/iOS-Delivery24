//
// DLInputCode.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 22.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLInputCode: View {
    let placeholder: String
    let text: Binding<String>

    var body: some View {
        TextField(placeholder, text: text)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(DLColor<SeparatorPalette>.gray.color)
            )
    }
}

// MARK: - Preview

#Preview {
    DLInputCode(placeholder: "joedoe@gmail.com", text: .constant(""))
        .padding(.horizontal)
}
