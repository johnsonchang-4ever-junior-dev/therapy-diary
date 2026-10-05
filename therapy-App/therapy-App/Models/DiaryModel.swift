//
//  DiaryModel.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import Foundation

struct Diary: Identifiable, Codable, Equatable {
    let id: String
    let time: String
    let dayPart: String
    let feeling: [String]
    let incident: String
    let instantFeel: [String]
    let thoughts: String
    let justWrite: String
    let intensity: Int

    /// "26 Mon 18:00"
    var dayLabel: String { formatted(as: "d EEE HH:mm") }

    /// "2026 July"
    var monthYearLabel: String { formatted(as: "yyyy MMMM") }

    /// "2026 July 26 Sat"
    var listDayLabel: String { formatted(as: "yyyy MMMM d EEE") }

    private func formatted(as output: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = inputFormatter.date(from: time) else { return time }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = output
        return outputFormatter.string(from: date)
    }
}

struct DiaryShelf: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let createdAt: String
    let updatedAt: String
    let diaries: [String]

    func entries(from all: [Diary]) -> [Diary] {
        all.filter { diaries.contains($0.id) }
    }
}

let diaries = [
    Diary(
        id: "ID1",
        time: "2024-01-28 10:30",
        dayPart: "Morning",
        feeling: [],
        incident: "",
        instantFeel: [],
        thoughts: "",
        justWrite: "My test Diary",
        intensity: 2
    ),
    Diary(
        id: "ID2",
        time: "2025-11-20 13:30",
        dayPart: "Afternoon",
        feeling: [],
        incident: "",
        instantFeel: [],
        thoughts: "",
        justWrite: "I just wanna write it down how I feel now, I feel so bad about my test results.",
        intensity: 8
    ),
    Diary(
        id: "ID3",
        time: "2026-07-26 21:30",
        dayPart: "Night",
        feeling: ["Tired", "Sleepy", "Angry"],
        incident: "My parcel is late again, I need it to arrive today.",
        instantFeel: ["Confused", "Frustrated"],
        thoughts: "This happen again? This is not the first time my parcel is delayed.",
        justWrite: "",
        intensity: 5
    ),
    Diary(
        id: "ID4",
        time: "2026-07-23 13:30",
        dayPart: "Afternoon",
        feeling: ["Irritated"],
        incident: "He changed the deadline without telling anyone again.",
        instantFeel: ["Anxious", "Angry"],
        thoughts: "This manager is not a good fit here.",
        justWrite: "",
        intensity: 8
    ),
    Diary(
        id: "ID5",
        time: "2026-07-20 17:30",
        dayPart: "Evening",
        feeling: ["Sleepy", "Low"],
        incident: "Cloudy day, I remember something happened when I was a child",
        instantFeel: ["Misunderstood"],
        thoughts: "My mom didn't want to believe what I said",
        justWrite: "",
        intensity: 6
    )
]

let diaryShelves = [
    DiaryShelf(
        title: "Emotion-Diary-2026",
        icon: "🔥",
        createdAt: "2026-07-20 10:30",
        updatedAt: "2026-07-26 21:30",
        diaries: ["ID3", "ID4", "ID5"]
    ),
    DiaryShelf(
        title: "Emotion-Diary-2025",
        icon: "🌙",
        createdAt: "2025-11-20 10:30",
        updatedAt: "2025-11-20 13:30",
        diaries: ["ID2"]
    ),
    DiaryShelf(
        title: "Emotion-Diary-2024",
        icon: "☁️",
        createdAt: "2024-01-28 09:30",
        updatedAt: "2024-01-28 10:30",
        diaries: ["ID1"]
    )
]

var recentShelves: [DiaryShelf] {
    Array(diaryShelves.sorted { $0.updatedAt > $1.updatedAt }.prefix(2))
}
