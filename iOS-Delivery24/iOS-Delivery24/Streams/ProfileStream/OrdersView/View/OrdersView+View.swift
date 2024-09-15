//
//  OrdersView+View.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import NavigationStackBackport
import SwiftUI

struct OrdersView: ViewModelable {
    @StateObject var viewModel = OrdersViewModel()
    @EnvironmentObject private var nav: Navigation
    @EnvironmentObject private var mainVM: MainViewModel

    var body: some View {
        stateScreenView
            .backport.navigationDestination(for: OrderDetailEntity.self) { order in
                OrderDetailView(order: order).environmentObject(viewModel)
            }
            .onAppear {
                viewModel.setReducers(nav: nav, mainVM: mainVM)
                viewModel.fetchOrders()
            }
    }
}

private extension OrdersView {

    @ViewBuilder
    var stateScreenView: some View {
        switch viewModel.uiProperties.screenState {
        case .initial, .loading:
            VStack {
                ForEach(0..<3, id: \.self) { _ in
                    ShimmeringView()
                        .frame(height: 174)
                        .clipShape(.rect(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
        case let .error(aPIError):
            ErrorView(error: aPIError)
        case .default:
            MainContainer
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
