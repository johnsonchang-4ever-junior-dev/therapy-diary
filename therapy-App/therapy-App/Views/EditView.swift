//
//  EditView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import SwiftUI

struct EditView: View {
    @State private var mode: DetailMode = .overview
    @State private var section: WritingSection = .justWrite
    @Environment(\.dismiss) private var dismiss

    let entry: Diary
    var body: some View {
        // Use Group to fix the bug that Picker is not responding when enter WriteView from OverView view's List NavigationLink
        Group {
            if mode == .writing {
                WriteView(entry: entry, mode: $mode, section: $section)
            } else {
                OverView(entry: entry, mode: $mode, section: $section)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Mode", selection: $mode) {
                    ForEach(DetailMode.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditView(entry: diaries[2])
    }
}
