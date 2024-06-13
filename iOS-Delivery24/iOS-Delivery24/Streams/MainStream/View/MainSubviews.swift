//
// MainSubviews.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension MainView {
    
    var MainBlock: some View {
        ScrollView {
            
        }
    }

    var BannersBlock: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.pink)
            .frame(maxWidth: .infinity, maxHeight: 460)
            .padding(.horizontal)
    }

    var ProductCard: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.gray)
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
