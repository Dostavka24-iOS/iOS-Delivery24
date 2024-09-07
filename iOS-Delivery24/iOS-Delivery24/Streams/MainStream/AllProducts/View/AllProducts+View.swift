//
//  AllProducts+View.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

struct AllProductsView: ViewModelable {
    @StateObject var viewModel: AllProductsViewModel
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        MainContainer.onAppear {
            viewModel.setReducers(nav: nav, mainVM: mainVM)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        AllProductsView(viewModel: .mockData)
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}
