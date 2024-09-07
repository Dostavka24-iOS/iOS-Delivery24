//
//  ___VARIABLE_productName:identifier___+View.swift
//  iOS-Delivery24
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___YEAR___ © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

struct ___VARIABLE_productName:identifier___View: ViewModelable {
    @StateObject var viewModel = ___VARIABLE_productName:identifier___ViewModel()
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
        ___VARIABLE_productName:identifier___View()
    }
    .environmentObject(Navigation())
    .environmentObject(MainViewModel.mockData)
}
