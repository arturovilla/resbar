//
//  Models.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/17/26.
//

import Foundation

// MARK: - Sort

enum SortOption: String, CaseIterable, Codable, Identifiable {
    case newestFirst
    case widthDesc
    case heightDesc
    case areaDesc
    case nameAsc

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .newestFirst: return "Newest"
        case .widthDesc:   return "Width (High → Low)"
        case .heightDesc:  return "Height (High → Low)"
        case .areaDesc:    return "Area (High → Low)"
        case .nameAsc:     return "Name (A → Z)"
        }
    }
}

// MARK: - Data Models (Persisted)

/// A user-saved resolution entry (not applied to system; just saved for reference).
struct SavedResolution: Identifiable, Codable, Hashable {
    var id: UUID = UUID()

    var name: String               // e.g. "YouTube Thumbnail", "iPad Landscape", "Projector"
    var width: Int                 // e.g. 1920
    var height: Int                // e.g. 1080

    var tags: Set<String> = []     // e.g. ["16:9", "web", "video"]
    var note: String? = nil        // optional extra context
    var createdAt: Date = Date()

    var area: Int { width * height }
    var label: String { "\(width)×\(height)" }
}

// MARK: - Display Snapshot (Not Persisted)

/// Lightweight snapshot of what’s currently connected (for reference at top of UI).
struct DisplaySnapshot: Identifiable, Hashable {
    let id: String                 // stable-ish identifier from the system query
    let name: String               // best-effort label
    let pointsWidth: Int
    let pointsHeight: Int
    let scale: Double

    var label: String {
        "\(pointsWidth)×\(pointsHeight) pts @ \(String(format: "%.1f", scale))x"
    }
}
