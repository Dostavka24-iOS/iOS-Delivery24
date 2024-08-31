//
//  DeliveryApp.swift
//  Delivery
//
//  Created by Dmitriy Permyakov on 13.06.2024.
//

import SwiftUI

@main
struct DeliveryApp: App {

    @StateObject var viewModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                MainBlock
                    .environment(\.mainWindowSize, proxy.size)
            }
            .onAppear(perform: viewModel.fetchData)
        }
    }

    @ViewBuilder
    var MainBlock: some View {
        if viewModel.uiProperties.screenState == .loading {
            StartLoadingView()
        } else {
            TabBarView()
                .environmentObject(viewModel)
        }
    }
}
