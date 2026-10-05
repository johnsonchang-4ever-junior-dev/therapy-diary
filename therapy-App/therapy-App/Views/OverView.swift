//
//  OverView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import SwiftUI

struct OverView: View {
    let entry: Diary
    @Binding var mode: DetailMode
    @Binding var section: WritingSection

    @State private var intensity: Double = 0
    @State private var showingEmotions = false
    @State private var showingInstantEmotions = false
    @State private var selectedFeelings: [String] = []
    @State private var selectedInstantFeel: [String] = []

    var body: some View {
        VStack {
            HStack {
                Text(entry.dayLabel)
                    .font(.headline)
                Spacer()
                Text(entry.monthYearLabel)
                    .font(.subheadline)
                Image(systemName: "pencil.circle")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(.secondarySystemFill), in: Capsule())
            .padding(.horizontal)
            .padding(.top)

            List {
                // I was feeling since morning ...(sheet)
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("I was feeling since morning ...")
                        Text(selectedFeelings.isEmpty ? "(Empty)" : emotionTagString(selectedFeelings))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    showingEmotions = true
                })

                // Then this happen ...
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Then this happen ...")
                        Text(entry.incident.isEmpty ? "(Empty)" : entry.incident)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    section = .incident
                    mode = .writing
                })

                // At that time I feel ... (sheet)
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("At that time I feel ...")
                        Text(selectedInstantFeel.isEmpty ? "(Empty)" : emotionTagString(selectedInstantFeel))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    showingInstantEmotions = true
                })

                // Instant voice in me ...
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Instant voice in me ...")
                        Text(entry.thoughts.isEmpty ? "(Empty)" : entry.thoughts)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    section = .thoughts
                    mode = .writing
                })

                // Just Write
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Just Write")
                        Text(entry.justWrite.isEmpty ? "(Empty)" : entry.justWrite)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    section = .justWrite
                    mode = .writing
                })

                // Intensity
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "circle")
                            .foregroundStyle(.secondary)
                        Text("Intensity")
                        Text("\(Int(intensity))/10")
                            .foregroundStyle(.blue)
                    }
                    Slider(value: $intensity, in: 0...10, step: 1)
                }
                .padding(.vertical, 12)
            }
        }
        .onAppear {
            intensity = Double(entry.intensity)
            selectedFeelings = entry.feeling
            selectedInstantFeel = entry.instantFeel
        }
        .sheet(isPresented: $showingEmotions) {
            EmotionView(selected: $selectedFeelings)
        }
        .sheet(isPresented: $showingInstantEmotions) {
            EmotionView(selected: $selectedInstantFeel)
        }
    }
}

#Preview {
    NavigationStack {
        OverView(entry: diaries[2], mode: .constant(.overview), section: .constant(.justWrite))
    }
}
