//
// DLButton.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLButton<
    TitleContent: View,
    SubtitleContent: View
>: View {
    struct Configuration {
        var titleView: TitleContent
        var subtileView: SubtitleContent?
        private(set) var vPadding: CGFloat

        init(titleView: () -> TitleContent, subtileView: () -> SubtitleContent) {
            self.titleView = titleView()
            self.subtileView = subtileView()
            self.vPadding = self.subtileView is EmptyView ? 22 : 12
        }
    }

    var configuration: Configuration
    var action: DLVoidBlock?

    var body: some View {
        Button {
            action?()
        } label: {
            VStack(spacing: .SPx0_5) {
                configuration.titleView
                if let subtitleView = configuration.subtileView {
                    subtitleView
                }
            }
            .padding(.vertical, configuration.vPadding)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(ButtonStyleView())
    }
}

extension DLButton.Configuration where SubtitleContent == EmptyView {

    init(@ViewBuilder titleView: () -> TitleContent) {
        self.titleView = titleView()
        self.subtileView = nil
        self.vPadding = 22
    }
}

// MARK: - Preview

@available(iOS 17, *)
#Preview {
    DLButton(
        configuration: .init(
            titleView: {
                Text("Title")
                    .style(size: 16, weight: .medium, color: .white)
            }, subtileView: {
                Text("Subtitle")
                    .style(size: 12, weight: .light, color: .white)
            }
        )
    )
    .padding(.horizontal)
}

@available(iOS 17, *)
#Preview {
    DLButton(
        configuration: .init(titleView: {
            Text("Text")
        })
    )
    .padding(.horizontal)
}

// MARK: - Helper

fileprivate struct ButtonStyleView: ButtonStyle {

    private let bgColor = DLColor<BackgroundPalette>.blue.color
    private let bgLightColor = DLColor<BackgroundPalette>(
        hexLight: 0x181B67,
        hexDark: 0x181B67
    ).color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                configuration.isPressed
                ? bgLightColor
                : bgColor,
                in: .rect(cornerRadius: 12)
            )
    }
}
