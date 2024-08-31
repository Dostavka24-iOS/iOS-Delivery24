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
    @EnvironmentObject private var mainViewModel: MainViewModel

    var body: some View {
        TabView(
            selection: $mainViewModel.uiProperties.tabItem
        ) {
            MainView()
                .contrasteTintTabItem(type: .house)

            CategoryView(
                viewModel: .init(
                    data: .init(
                        userToken: mainViewModel.data.userModel?.token
                    )
                )
            )
            .contrasteTintTabItem(type: .catalog)

            BasketView(
                viewModel: .init()
            )
            .contrasteTintTabItem(type: .cart)
            .badge(mainViewModel.uiProperties.basketBadge)

            ProfileScreen(
                viewModel: .init()
            )
            .contrasteTintTabItem(type: .profile)
        }
        .tint(DLColor<IconPalette>.primary.color)
        .onChange(of: mainViewModel.uiProperties.tabItem) { value in
            print("[DEBUG]: \(value)")
        }
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

#Preview("Mock Data") {
    TabBarView()
        .setScreenSizeForPreview
        .environmentObject(MainViewModel.mockData)
}

#Preview("Network") {
    let vm = MainViewModel.mockData
    return TabBarView()
        .setScreenSizeForPreview
        .onAppear {
            vm.fetchData()
        }
        .environmentObject(vm)
}
