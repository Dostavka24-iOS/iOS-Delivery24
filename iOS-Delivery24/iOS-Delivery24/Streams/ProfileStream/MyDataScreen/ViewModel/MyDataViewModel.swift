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
    @Published var userModel: UserModel
    @Published var uiProperties: UIProperties

    init(
        userModel: UserModel,
        uiProperties: UIProperties = .init()
    ) {
        self.userModel = userModel
        self.uiProperties = .init(
            emailInput: userModel.email,
            phoneInput: userModel.phone,
            confirmationEmailСodeInput: uiProperties.confirmationEmailСodeInput,
            confirmationPhoneСodeInput: uiProperties.confirmationPhoneСodeInput,
            companyName: userModel.name,
            inn: userModel.inn,
            kpp: userModel.kpp
        )
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
    MyDataScreen(viewModel: .init(userModel: .mockData))
}
