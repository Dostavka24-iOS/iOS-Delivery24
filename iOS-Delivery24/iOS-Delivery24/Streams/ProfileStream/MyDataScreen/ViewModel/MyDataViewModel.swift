//
// MyDataViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

protocol MyDataViewModelProtocol: ViewModelProtocol {
    func didTapGetCodeForEmail()
    func didTapConfirmEmailCode()
    func didTapGetCall()
    func didTapGetCodeForPhone()
    func didTapConfirmPhoneCode()
    func didTapSave()

    var codeForEmailDidEntered: Bool { get }
    var codeForPhoneDidEntered: Bool { get }
}

final class MyDataViewModel: MyDataViewModelProtocol {
    @Published var uiProperties: UIProperties

    init(uiProperties: UIProperties = .init()) {
        self.uiProperties = uiProperties
    }

    var codeForEmailDidEntered: Bool {
        !uiProperties.confirmationEmailСodeInput.isEmpty
    }
    var codeForPhoneDidEntered: Bool {
        !uiProperties.confirmationPhoneСodeInput.isEmpty
    }
}

// MARK: - Actions

extension MyDataViewModel {

    func didTapGetCodeForEmail() {
    }

    func didTapConfirmEmailCode() {
        print("[DEBUG]: \(uiProperties.confirmationEmailСodeInput)")
    }

    func didTapGetCall() {
    }

    func didTapGetCodeForPhone() {
    }

    func didTapConfirmPhoneCode() {
        print("[DEBUG]: \(uiProperties.confirmationPhoneСodeInput)")
    }

    func didTapSave() {
        print("[DEBUG]: Нажали кнопку сохранить")
    }
}

import SwiftUI

#Preview {
    MyDataScreen()
}
