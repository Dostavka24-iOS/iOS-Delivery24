//
//  ___VARIABLE_productName:identifier___+Subviews.swift
//  iOS-Delivery24
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___YEAR___ © Dostavka24 LLC. All rights reserved.
//

import SwiftUI

extension ___VARIABLE_productName:identifier___View {

    var MainContainer: some View {
        Text("___VARIABLE_productName:identifier___View")
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

// MARK: - Constants

private extension ___VARIABLE_productName:identifier___View {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
