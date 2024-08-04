//
// MakeOrderViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol MakeOrderViewModelProtocol: ViewModelProtocol {
    // MARK: Actions
    func didTapApplyBonuses()
    func didTapMakeOrder()
}

final class MakeOrderViewModel: MakeOrderViewModelProtocol {
    @Published var resultData: ResultData
    @Published var uiProperties: UIProperies

    init(
        resultData: ResultData,
        uiProperties: UIProperies = .init()
    ) {
        self.uiProperties = uiProperties
        self.resultData = resultData
    }

    var bonusesIncluded: Bool {
        uiProperties.bonusesIncluded
    }
}

// MARK: - Actions

extension MakeOrderViewModel {
    
    /// Нажали `применить` бонусы
    func didTapApplyBonuses() {
        // Число должно быть кратным 100
        guard let number = Int(uiProperties.bonusesCount), number % 100 == 0 else { return }
        resultData.bonusesCount = uiProperties.bonusesCount
    }
    
    /// Нажали `Оформить заказ`
    func didTapMakeOrder() {
        print("[DEBUG]: Нажали оформить заказ")
    }
}
