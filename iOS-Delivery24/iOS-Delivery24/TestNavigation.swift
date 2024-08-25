//
// TestNavigation.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import NavigationStackBackport

struct TestNavigation: View {
    @StateObject private var nav = Navigation()

    var body: some View {
        NavigationStackBackport.NavigationStack(path: $nav.path) {
            Button("Push") {
                nav.addScreen(screen: "Hello World")
            }
            .backport.navigationDestination(for: String.self) { value in
                if value == "Hello World" {
                    TestNavigation2()
                        .navigationTitle(value)
                } else {
                    TestNavigation3()
                        .navigationTitle(value)
                }
            }
        }
        .environmentObject(nav)
    }
}

struct TestNavigation2: View {

    @EnvironmentObject var nav: Navigation
    var body: some View {
        Button("to 2 sreen") {
            nav.addScreen(screen: "to tree")
        }
    }
}

struct TestNavigation3: View {
    @EnvironmentObject var nav: Navigation
    var body: some View {
        Text("3 screen").onTapGesture {
            nav.openPreviousScreen()
        }
    }
}

#Preview {
    TestNavigation()
}
