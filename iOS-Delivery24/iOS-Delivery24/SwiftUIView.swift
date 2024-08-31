//
// SwiftUIView.swift
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
        let touchPoint = gestureRecognizer.location(in: self.view)
        let isTouchInLeftHalf = touchPoint.x < view.bounds.width / 2
        return isSystemSwipeToBackEnabled && isTouchInLeftHalf
    }
}

// MARK: - SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            TempView()
        }
    }
}

struct TempView: View {
    var body: some View {
        VStack {
            Text("Main View")
            NavigationLink(destination: DetailView()) {
                Text("Go to Detail")
            }
        }
    }
}

struct DetailView: View {

    var body: some View {
        VStack {
            Text("Detail View")
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {

                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Пока")
                    }
                }
            }
        }
        .onAppear {
//            var backButtonBackgroundImage = UIImage(systemName: "chevron.left.circle.fill")!
//
//            backButtonBackgroundImage = backButtonBackgroundImage.applyingSymbolConfiguration(
//                .init(
//                    paletteColors: [.red, .yellow]
//                )
//            )!
//            UINavigationBar.appearance().backIndicatorImage = backButtonBackgroundImage
//            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonBackgroundImage

//            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//            UINavigationBar.appearance().shadowImage = UIImage()
//            UINavigationBar.appearance().isTranslucent = true
//            UINavigationBar.appearance().backgroundColor = .clear
        }
    }
}

#Preview {
    ContentView()
}
