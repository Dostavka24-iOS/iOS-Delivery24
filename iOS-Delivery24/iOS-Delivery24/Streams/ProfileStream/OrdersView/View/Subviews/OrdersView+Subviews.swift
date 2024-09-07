//
//  OrdersView+Subviews.swift
//  iOS-Delivery24
//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

extension OrdersView {

    var MainContainer: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.data.orders) { order in
                    if let configuration = order.mapper, let id = order.id {
                        DLOrderInfoCell(
                            configuration: configuration,
                            handlerConfigurations: .init(
                                didTapInfo: {
                                    viewModel.didTapOrderInfo(orderID: id)
                                },
                                didTapReload: viewModel.didTapReloadOrder
                            )
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .searchable(
            text: $viewModel.uiProperties.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                WalletView(moneyCount: viewModel.data.moneyCount)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        OrdersView(viewModel: .mockData)
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}

// MARK: - Constants

private extension OrdersView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let navigationTitle = "Заказы"
    }
}
