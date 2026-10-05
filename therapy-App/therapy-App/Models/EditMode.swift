//
//  EditMode.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/30.
//

import Foundation

enum DetailMode: String, CaseIterable {
    case overview = "Overview"
    case writing = "Writing"
}

enum WritingSection: String, CaseIterable {
    case incident = "Then this happen ..."
    case thoughts = "Instant voice in me ..."
    case justWrite = "Just Write"
}
