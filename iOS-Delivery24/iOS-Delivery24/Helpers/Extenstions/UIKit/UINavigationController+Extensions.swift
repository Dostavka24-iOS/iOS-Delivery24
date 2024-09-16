//
// UINavigationController+Extensions.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        setCustomGesture()
    }

    func setCustomGesture() {
        interactivePopGestureRecognizer?.isEnabled = false
        let customPanGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleCustomPanGesture)
        )
        customPanGestureRecognizer.delegate = self
        view.addGestureRecognizer(customPanGestureRecognizer)
    }

    @objc private func handleCustomPanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let interactivePopGestureRecognizer else { return }
        if let targets = interactivePopGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
            gestureRecognizer.setValue(targets, forKey: "targets")
        }
        interactivePopGestureRecognizer.state = gestureRecognizer.state
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
