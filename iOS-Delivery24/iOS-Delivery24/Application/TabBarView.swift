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
            MainView()
                .contrasteTintTabItem(type: .house)

            CategoryView(
                viewModel: .mockData
            )
            .contrasteTintTabItem(type: .catalog)

            BasketView(
                viewModel: .mockData
            )
            .contrasteTintTabItem(type: .cart)

            ProfileScreen(
                viewModel: .mockData
            )
            .contrasteTintTabItem(type: .profile)
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

    func contrasteTintTabItem(
        type: TabBarItem
    ) -> some View {
        tabItem {
            TabViewItem(type: type)
        }
        .tint(DLColor<IconPalette>.primary.color)
        .tag(type)
    }
}

// MARK: - Preview

#Preview {
    TabBarView()
        .environmentObject(MainViewModel.mockData)
}
