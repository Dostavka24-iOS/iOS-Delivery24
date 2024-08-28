//
// DLStepper.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLStepper: View {

    struct Configuration {
        var startCounter = 0
        var magnifier = 1
    }

    struct HandlerConfiguration {
        var didTapPlus: DLIntBlock?
        var didTapMinus: DLIntBlock?
    }

    let configuration: Configuration
    var handlerConfiguration = HandlerConfiguration()
    @State private var counter = 0

    init(
        configuration: Configuration,
        handlerConfiguration: HandlerConfiguration = HandlerConfiguration()
    ) {
        self.configuration = configuration
        self.handlerConfiguration = handlerConfiguration
        self._counter = State(initialValue: configuration.startCounter)
    }

    var body: some View {
        StepperView
    }

    private var StepperView: some View {
        HStack(spacing: 12) {
            Button {
                counter = max(0, counter - configuration.magnifier)
                handlerConfiguration.didTapMinus?(counter)
            } label: {
                Image(.minus)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(
                        counter == 0 ? .white : DLColor<IconPalette>.blue.color
                    )
                    .frame(maxHeight: .infinity)
            }
            .disabled(counter <= 0)

            Text("\(counter)")
                .style(size: 16, weight: .bold, color: DLColor<TextPalette>.primary.color)
                .frame(minWidth: 49)

            Button {
                counter += configuration.magnifier
                handlerConfiguration.didTapPlus?(counter)
            } label: {
                Image(.plus)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundStyle(DLColor<IconPalette>.primary.color)
                    .frame(maxHeight: .infinity)
            }
        }
        .padding(.horizontal)
        .frame(height: 43)
        .background(DLColor<BackgroundPalette>.lightGray.color, in: .rect(cornerRadius: 12))
    }
}

// MARK: - Preview

#Preview {
    DLStepper(
        configuration: .init(
            startCounter: 3,
            magnifier: 2
        )
    )
}
