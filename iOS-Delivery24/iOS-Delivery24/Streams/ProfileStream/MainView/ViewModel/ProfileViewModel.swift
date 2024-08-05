//
// ProfileViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 05.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI

protocol ProfileViewModelProtocol: ViewModelProtocol {
}

final class ProfileViewModel: ProfileViewModelProtocol {
    private(set) var data: ProfileData

    init(data: ProfileData = .init()) {
        self.data = data
    }
}
