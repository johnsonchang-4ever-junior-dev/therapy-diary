//
//  WriteView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import SwiftUI

struct WriteView: View {
    let entry: Diary
    @Binding var mode: DetailMode
    @Binding var section: WritingSection

    @State private var text: String = ""

    private var placeholder: String {
        switch section {
        case .incident: "Then this happen ..."
        case .thoughts: "I heard a voice saying ..."
        case .justWrite: "Just write ..."
        }
    }

    private func text(for section: WritingSection) -> String {
        switch section {
        case .incident: entry.incident
        case .thoughts: entry.thoughts
        case .justWrite: entry.justWrite
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Menu {
                Picker("Section", selection: $section) {
                    ForEach(WritingSection.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            } label: {
                HStack {
                    Text(section.rawValue)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(.secondarySystemFill), in: Capsule())
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
            .padding(.top)

            TextField(placeholder, text: $text, axis: .vertical)
                .lineLimit(5...)
                .padding(.horizontal)
                .padding(.top, 8)

            Spacer()
        }
        .onAppear {
            text = text(for: section)
        }
        .onChange(of: section) {
            text = text(for: section)
        }
    }
}

#Preview {
    NavigationStack {
        WriteView(entry: diaries[2], mode: .constant(.writing), section: .constant(.justWrite))
    }
}
