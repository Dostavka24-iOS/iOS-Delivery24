//
// TempView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 03.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

final class Navigation: ObservableObject {
    @Published var screensIsActive: [Screens: Bool] = [:]
    enum Screens {
        case screen1
        case screen2
        case screen3
        case screen4
    }
}

struct CustomNavigation<Screen: View, Label: View>: View {
    @ObservedObject var nav: Navigation
    var screenKey: Navigation.Screens
    var screenView: () -> Screen
    var labelView: () -> Label

    var body: some View {
        NavigationLink(
            isActive: Binding(
                get: {
                    nav.screensIsActive[screenKey] ?? false
                },
                set: {
                    print("[DEBUG]: уставновка \($0) для \(screenKey)")
                    nav.screensIsActive[screenKey] = true
                }
            )
        ) {
            screenView()
        } label: {
            labelView()
        }
    }
}

struct Streen1: View {
    @StateObject private var nav = Navigation()
    var body: some View {
        NavigationView {
//            CustomNavigation(
//                nav: nav,
//                screenKey: .screen1,
//                screenView: { Streen2() },
//                labelView: { Text("Screen 2") }
//            )
            NavigationLink(isActive: .constant(nav.screensIsActive[.screen2] ?? false)) {
                Streen2()
            } label: {
                Text("Streen 2").onTapGesture {
                    nav.screensIsActive[.screen2] = true
                }
            }
            .navigationTitle("Screen 1")
        }
        .environmentObject(nav)
    }
}

struct Streen2: View {
    @EnvironmentObject private var nav: Navigation
    var body: some View {
        NavigationLink(isActive: .constant(nav.screensIsActive[.screen3] ?? false)) {
            Streen3()
        } label: {
            Text("Streen 3").onTapGesture {
                nav.screensIsActive[.screen3] = true
            }
        }
        .navigationTitle("Screen 2")
    }
}

struct Streen3: View {
    @EnvironmentObject private var nav: Navigation
    var body: some View {
        VStack {
            NavigationLink(isActive: .constant(nav.screensIsActive[.screen4] ?? false)) {
                Streen4()
            } label: {
                Text("Streen 4")
            }

            Button {
                nav.screensIsActive[.screen3] = false
            } label: {
                Text("Screen 2")
            }
        }
        .navigationTitle("Screen 3")
    }
}

struct Streen4: View {
    @EnvironmentObject private var nav: Navigation

    var body: some View {
        VStack {
            Text("Это экран 3")

            Button("Screen 1") {
                nav.screensIsActive[.screen1] = false
            }
        }
        .navigationTitle("Screen 4")
    }
}

#Preview {
    Streen1()
}
