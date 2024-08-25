//
// TabBarView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

struct TabBarView: View {
    @State private var tabItem: TabBarItem = .house

    init() {
        UITabBar.appearance().backgroundColor = DLColor<BackgroundPalette>.gray100.uiColor
    }

    var body: some View {
        TabView(selection: $tabItem) {
            MainView(
                viewModel: .mockData
            )
            .tag(TabBarItem.house)
            .contrasteTintTabItem {
                TabViewItem(type: .house)
            }

            CategoryView(
                viewModel: .mockData
            )
            .tag(TabBarItem.catalog)
            .contrasteTintTabItem {
                TabViewItem(type: .catalog)
            }

            BasketView(
                viewModel: .mockData
            )
            .tag(TabBarItem.cart)
            .contrasteTintTabItem {
                TabViewItem(type: .cart)
            }

            ProfileScreen(
                viewModel: .mockData
            )
            .tag(TabBarItem.profile)
            .contrasteTintTabItem {
                TabViewItem(type: .profile)
            }
        }
        .tint(DLColor<IconPalette>.primary.color)
    }
}

// MARK: - Helper

private struct TabViewItem: View {

    var type: TabBarItem

    var body: some View {
        VStack {
            type.image.renderingMode(.template)
            Text(type.rawValue)
                .font(.system(size: 10, weight: .medium))
        }
    }
}

private extension View {

    func contrasteTintTabItem<T: View>(
        @ViewBuilder _ content: @escaping () -> T
    ) -> some View {
        tabItem {
            content()
        }
        .tint(DLColor<IconPalette>.primary.color)
    }
}

// MARK: - Preview

#Preview {
    TabBarView()
}
