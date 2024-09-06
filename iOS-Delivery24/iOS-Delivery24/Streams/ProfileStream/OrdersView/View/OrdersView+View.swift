//
//  OrdersView+View.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

struct OrdersView: ViewModelable {
    @StateObject var viewModel = OrdersViewModel()
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
        OrdersView()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}
