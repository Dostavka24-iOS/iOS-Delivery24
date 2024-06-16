//
// DTag.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DTag: View {
    
    var iconKind: IconKind
    var title: String

    var body: some View {

        HStack(spacing: .SPx2) {
            Image(iconKind.icon)
            Text(title)
        }
        .padding(.horizontal, .SPx3)
        .padding(.vertical, .SPx2)
        .background(.gray) // FIXME: iOS-3: Поправить на цвет ДС
        .clipShape(RoundedRectangle(cornerRadius: .CRx3))
    }
}

#Preview {
    VStack {
        DTag(iconKind: .discount, title: "Акции")
        DTag(iconKind: .hits, title: "Хиты продаж")
        DTag(iconKind: .new, title: "Новинки")
    }
}
