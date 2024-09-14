//
// DTagsSection.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 24.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DTagsSection: View {

    var sections: [MainViewModel.Section]
    @Binding var lastSelectedItem: String?
    @State private var lastSelectedItemHScroll: String?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { reader in
                HStack(spacing: .SPx2) {
                    ForEach(sections) { section in
                        DTag(
                            iconKind: section.iconKind,
                            title: section.title.capitalizingFirstLetter
                        )
                        .id("scroll_h_id_\(section.id)")
                        .onTapGesture {
                            lastSelectedItem = "scroll_section_id_\(section.id)"
                            lastSelectedItemHScroll = String(section.id)
                        }
                    }
                }
                .padding(.horizontal)
                .onChange(of: lastSelectedItemHScroll) { id in
                    guard let id else { return }
                    withAnimation {
                        reader.scrollTo("scroll_h_id_\(id)", anchor: .center)
                    }
                }
            }
        }
        .padding(.top, .SPx2)
        .padding(.bottom, .SPx3)
    }
}

private extension MainViewModel.Section {

    var iconKind: DTag.IconKind {
        switch self {
        case .actions:
            return .discount
        case .exclusives:
            return .clear
        case .news:
            return .new
        case .hits:
            return .hits
        }
    }
}

#Preview {
    DTagsSection(
        sections: [
            .exclusives([]),
            .hits([]),
            .actions([]),
            .news([])
        ],
        lastSelectedItem: .constant("")
    )
}
