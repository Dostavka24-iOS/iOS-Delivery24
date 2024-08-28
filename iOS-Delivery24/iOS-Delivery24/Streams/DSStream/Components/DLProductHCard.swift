//
// DLProductHCard.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLProductHCard: View {

    let configuration: Configuration
    var handlerConfiguration: HandlerConfiguration = .init()

    @State private var counter = 0
    @State private var isLiked = false

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            HStack(spacing: 0) {
                DLImageView(configuration: .init(imageKind: configuration.imageKind))
                    .frame(width: size.width * 0.35)

                VStack(alignment: .leading) {
                    ProductContent

                    Spacer()

                    ButtonsView
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 12)
                }
                .frame(width: size.width * 0.65)
            }
            .frame(width: size.width, height: size.height)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(alignment: .topLeading) {
                LikeButton
                    .padding([.leading, .top], 8)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
                    .fill(DLColor<SeparatorPalette>.gray.color)
            }
        }
        .onAppear(perform: onAppear)
    }
}

// MARK: - Action

private extension DLProductHCard {

    func onAppear() {
        isLiked = configuration.isLiked
        counter = Int(configuration.count) ?? 0
    }

    func didTapLike() {
        isLiked.toggle()
        handlerConfiguration.didTapLike?(isLiked)
    }

    func didTapMinus() {
        guard counter > 0 else { return }
        counter -= 1
        handlerConfiguration.didTapMinus?(counter)
    }

    func didTapPlus() {
        counter += 1
        handlerConfiguration.didTapPlus?(counter)
    }

    func didTapDelete() {
        handlerConfiguration.didTapDelete?(counter)
    }
}

// MARK: - Configuration

extension DLProductHCard {

    struct Configuration {
        var title: String
        var price: String
        var unitPrice: String
        var cornerPrice: String
        var count: String
        var isLiked: Bool
        var imageKind: ImageKind
    }
}

// MARK: - HandlerConfiguration

extension DLProductHCard {

    struct HandlerConfiguration {
        var didTapPlus: DLIntBlock?
        var didTapMinus: DLIntBlock?
        var didTapLike: DLBoolBlock?
        var didTapDelete: DLIntBlock?
    }
}

// MARK: - UI Subviews

private extension DLProductHCard {

    var ProductContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(configuration.price)
                .font(.headline)
                .foregroundStyle(DLColor<TextPalette>.primary.color)

            Text(configuration.unitPrice)
                .style(size: 14, weight: .medium, color: DLColor<TextPalette>.gray800.color)

            Text(configuration.title)
                .style(size: 14, weight: .semibold, color: DLColor<TextPalette>.primary.color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 12)
    }

    var ButtonsView: some View {
        HStack(spacing: 12) {
            Button(action: didTapDelete, label: {
                Image(.trash)
                    .frame(width: 32, height: 32)
                    .background(DLColor<BackgroundPalette>.lightGray.color, in: .circle)
            })

            StepperView
        }
    }

    var StepperView: some View {
        #warning("НЕ ЗАБЫТЬ")
        // TODO: Добавить тут логики получения из MainViewModel
        DLStepper(
            configuration: <#T##DLStepper.Configuration#>,
            handlerConfiguration: <#T##DLStepper.HandlerConfiguration#>
        )
//        HStack(spacing: 12) {
//            Button(action: didTapMinus, label: {
//                Image(.minus)
//                    .renderingMode(.template)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 16)
//                    .foregroundStyle(
//                        counter == 0 ? .white : DLColor<IconPalette>.blue.color
//                    )
//                    .frame(maxHeight: .infinity)
//            })
//            .disabled(counter == 0)
//
//            Text("\(counter)")
//                .style(size: 16, weight: .bold, color: DLColor<TextPalette>.primary.color)
//                .frame(minWidth: 49)
//
//            Button(action: didTapPlus, label: {
//                Image(.plus)
//                    .renderingMode(.template)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 16, height: 16)
//                    .foregroundStyle(DLColor<IconPalette>.primary.color)
//                    .frame(maxHeight: .infinity)
//            })
//        }
//        .padding(.horizontal)
//        .frame(height: 43)
//        .background(DLColor<BackgroundPalette>.lightGray.color, in: .rect(cornerRadius: 12))
    }

    var LikeButton: some View {
        Button(action: didTapLike, label: {
            Image(isLiked ? .filledLike : .like)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .padding(10)
                .frame(width: 36, height: 36)
        })
        .background(.white, in: .circle)
    }
}

// MARK: - Preview

#Preview {
    DLProductHCard(
        configuration: .init(
            title: "Жвачка \"Лов Из\" Банан/Клубника",
            price: "303 ₽",
            unitPrice: "3.03 ₽/шт",
            cornerPrice: "1.14",
            count: "0",
            isLiked: true,
            imageKind: .image(Image(.bestGirl))
        )
    )
    .frame(height: 174)
    .padding(.horizontal, 8)
}
