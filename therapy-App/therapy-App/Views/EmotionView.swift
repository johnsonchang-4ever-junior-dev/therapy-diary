//
//  EmotionView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import SwiftUI

// the Emotion Sheet
struct EmotionView: View {
    @Binding var selected: [String]
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""
    @State private var draft: Set<String>

    init(selected: Binding<[String]>) {
        self._selected = selected
        self._draft = State(initialValue: Set(selected.wrappedValue))
    }

    private var visibleGroups: [EmotionGroup] {
        emotionGroups(matching: searchText)
    }

    private func toggle(_ emotion: String) {
        if draft.contains(emotion) {
            draft.remove(emotion)
        } else {
            draft.insert(emotion)
        }
    }

    private func confirm() {
        selected = Array(draft)
        dismiss()
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(visibleGroups) { group in
                    Section(group.id) {
                        ForEach(group.emotions, id: \.self) { emotion in
                            Button {
                                toggle(emotion)
                            } label: {
                                HStack {
                                    if draft.contains(emotion) {
                                        Image(systemName: "checkmark")
                                    }
                                    Text(emotion)
                                    Spacer()
                                }
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Choose your Emotion")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark", action: dismiss.callAsFunction)
                        .labelStyle(.iconOnly)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", systemImage: "checkmark", action: confirm)
                        .labelStyle(.iconOnly)
                }
            }
        }
    }
}

#Preview {
    EmotionView(selected: .constant(["Tired", "Sleepy"]))
}
