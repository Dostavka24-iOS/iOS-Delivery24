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
        let isSystemSwipeToBackEnabled = viewControllers.count > 1
        let touchPoint = gestureRecognizer.location(in: view)
        let isTouchInLeftHalf = touchPoint.x < view.bounds.width / 2
        return isSystemSwipeToBackEnabled && isTouchInLeftHalf
    }
}
