//
//  ___VARIABLE_productName:identifier___+ViewModel.swift
//  iOS-Delivery24
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___YEAR___ © Dostavka24 LLC. All rights reserved.
//

import Foundation
import Combine

protocol ___VARIABLE_productName:identifier___ViewModelProtocol: ViewModelProtocol {
    // MARK: Networks
    // MARK: Actions
    // MARK: Reducers
    func setReducers(nav: Navigation, mainVM: MainViewModel)
    // MARK: Values
    var data: ___VARIABLE_productName:identifier___VMData { get }
    var uiProperties: ___VARIABLE_productName:identifier___ViewModel.UIProperties { get set }
}

final class ___VARIABLE_productName:identifier___ViewModel: ___VARIABLE_productName:identifier___ViewModelProtocol {
    @Published private(set) var data: ___VARIABLE_productName:identifier___VMData
    @Published var uiProperties: UIProperties
    private var reducers = Reducers()
    private var store: Set<AnyCancellable> = []

    init(
        data: ___VARIABLE_productName:identifier___VMData = .init(),
        uiProperties: UIProperties = .init()
    ) {
        self.data = data
        self.uiProperties = uiProperties
    }
}

// MARK: - Network

extension ___VARIABLE_productName:identifier___ViewModel {
}

// MARK: - Actions

extension ___VARIABLE_productName:identifier___ViewModel {
}

// MARK: - Reducers

extension ___VARIABLE_productName:identifier___ViewModel {

    func setReducers(nav: Navigation, mainVM: MainViewModel) {
        reducers.nav = nav
        reducers.mainVM = mainVM
    }
}
