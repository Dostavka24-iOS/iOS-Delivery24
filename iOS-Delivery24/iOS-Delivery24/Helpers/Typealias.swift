//
// Typealias.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

typealias DLVoidBlock = () -> Void
typealias DLViewBlock<T: UIView> = (T) -> Void
typealias DLIntBlock = (Int) -> Void
typealias DLStringBlock = (String) -> Void
typealias DLBoolBlock = (Bool) -> Void
typealias DLGenericBlock<T> = (T) -> Void
typealias DLResultBlock<T, T1: Error> = (Result<T, T1>) -> Void
