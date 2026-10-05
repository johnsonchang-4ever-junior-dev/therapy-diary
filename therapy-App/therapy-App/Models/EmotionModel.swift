//
//  EmotionModel.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import Foundation

struct EmotionGroup: Identifiable {
    let id: String
    let emotions: [String]
}

let emotionGroups = [
    EmotionGroup(id: "Bad", emotions: [
        "Bored", "Busy", "Stressed", "Tired",
        "Unfocussed", "Sleepy", "Out of control", "Overwhelmed", "Rushed",
        "Pressured", "Apathetic", "Indifferent", "Bad"
    ]),
    EmotionGroup(id: "Happy", emotions: [
        "Optimistic", "Trusting", "Peaceful", "Powerful", "Accepted", "Proud",
        "Interested", "Content", "Playful",
        "Inspired", "Hopeful", "Intimate", "Thankful", "Loving", "Creative",
        "Courageous", "Valued", "Respected", "Confident", "Successful", "Happy",
        "Inquisitive", "Curious", "Joyful", "Free", "Cheeky", "Aroused", "Energetic"
    ]),
    EmotionGroup(id: "Sad", emotions: [
        "Hurt", "Depressed", "Guilty", "Despair", "Vulnerable", "Lonely",
        "Disappointed", "Inferior", "Empty", "Remorseful", "Ashamed",
        "Powerless", "Grief", "Fragile", "Victimised", "Abandoned", "Isolated"
    ]),
    EmotionGroup(id: "Surprised", emotions: [
        "Startled", "Confused", "Amazed", "Excited",
        "Shocked", "Dismayed", "Disillusioned", "Perplexed", "Astonished",
        "Awe", "Eager", "Sad"
    ]),
    EmotionGroup(id: "Disgusted", emotions: [
        "Disapproving", "Disappointed", "Awful", "Repelled",
        "Judgmental", "Embarrassed", "Appalled", "Revolted",
        "Nauseated", "Detestable", "Horrified", "Hesitant", "Disgusted"
    ]),
    EmotionGroup(id: "Angry", emotions: [
        "Let down", "Humiliated", "Bitter", "Mad", "Aggressive", "Frustrated",
        "Distant", "Critical",
        "Betrayed", "Resentful", "Disrespected", "Ridiculed", "Indignant",
        "Violated", "Furious", "Jealous", "Provoked", "Hostile", "Infuriated",
        "Annoyed", "Withdrawn", "Numb", "Sceptical", "Dismissive", "Angry"
    ]),
    EmotionGroup(id: "Fearful", emotions: [
        "Scared", "Anxious", "Insecure", "Weak", "Rejected", "Threatened",
        "Helpless", "Frightened", "Overwhelmed", "Worried", "Inadequate",
        "Inferior", "Worthless", "Insignificant", "Excluded", "Persecuted",
        "Nervous", "Exposed", "Fearful"
    ])
]

func emotionGroups(matching search: String) -> [EmotionGroup] {
    if search.isEmpty { return emotionGroups }
    return emotionGroups.compactMap { group in
        let matches = group.emotions.filter {
            $0.localizedCaseInsensitiveContains(search)
        }
        return matches.isEmpty ? nil : EmotionGroup(id: group.id, emotions: matches)
    }
}

func emotionTagString(_ emotions: [String]) -> String {
    emotions.map { "#\($0)" }.joined(separator: " ")
}
