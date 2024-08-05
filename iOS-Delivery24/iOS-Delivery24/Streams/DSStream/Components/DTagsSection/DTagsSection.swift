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
    var scrollSectionId: ((String) -> Void)?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .SPx2) {
                ForEach(sections) { section in
                    DTag(iconKind: section.iconKind, title: section.title.capitalizingFirstLetter)
                        .onTapGesture {
                            scrollSectionId?("scroll_section_id_\(section.id)")
                        }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, .SPx2)
        .padding(.bottom, .SPx3)
    }
}

fileprivate extension MainViewModel.Section {

    var iconKind: DTag.IconKind {
        switch self {
        case .stocks:
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
            .stocks([]),
            .news([])
        ]
    )
}
