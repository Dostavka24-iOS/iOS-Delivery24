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
            MainBlock
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
