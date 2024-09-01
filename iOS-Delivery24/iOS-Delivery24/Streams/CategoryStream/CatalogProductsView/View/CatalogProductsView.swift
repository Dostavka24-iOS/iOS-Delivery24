//
// CatalogProductsView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 01.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct CatalogProductsView: ViewModelable {

    @StateObject var viewModel: CatalogProductsViewModel

    var body: some View {
        MainContainer
    }
}

// MARK: - Preview

#Preview {
    CatalogProductsView(viewModel: .mockData)
}
