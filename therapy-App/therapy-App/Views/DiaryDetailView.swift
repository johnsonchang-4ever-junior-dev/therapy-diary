//
//  DiaryDetailView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import SwiftUI

struct DiaryDetailView: View {
    let diary: DiaryShelf

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        VStack {
            Text(diary.icon + " " + diary.title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            List {
                ForEach(diary.entries(from: diaries)) { entry in
                    NavigationLink {
                        EditView(entry: entry)
                    } label: {
                        Text(entry.listDayLabel)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    // Save logic here
                    dismiss()
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button("Add", systemImage: "plus.circle") {
                    // Add diary action later
                }
                .labelStyle(.iconOnly)
            }
        }
    }
}




#Preview {
    NavigationStack {
        DiaryDetailView(diary: DiaryShelf(
        title: "Emotion-Diary-2026",
        icon: "🔥",
        createdAt: "2026-07-20 10:30",
        updatedAt: "2026-07-26 21:30",
        diaries: ["ID3", "ID4", "ID5"]
        ))
    }
}
