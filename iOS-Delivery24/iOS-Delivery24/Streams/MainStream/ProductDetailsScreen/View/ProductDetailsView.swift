//
// ProductDetailsView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct ProductDetailsView: ViewModelable {
    @StateObject var viewModel: ProductDetailsViewModel

    var body: some View {
        MainContainer
            .onAppear(perform: viewModel.fetchData)
    }
}

// MARK: - Preview

#Preview {
    ProductDetailsView(viewModel: .mockData)
}
