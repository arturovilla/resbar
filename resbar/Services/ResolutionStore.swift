//
//  ResolutionStore.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/17/26.
//

import Foundation

/// JSON persistence for user-saved resolutions.
/// Stores a single file in Application Support: `resbar/resolutions.json`
final class ResolutionStore {
    struct Payload: Codable {
        var saved: [SavedResolution] = []
    }
    private struct DefaultResolution: Codable {
        let name: String
        let width: Int
        let height: Int
        let tags: [String]?
        let note: String?
    }

    private let fileURL: URL

    init(appFolderName: String = "resbar", fileName: String = "resolutions.json") {
        let fm = FileManager.default
        let base = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let folder = base.appendingPathComponent(appFolderName, isDirectory: true)

        // Ensure Application Support/resbar exists
        if !fm.fileExists(atPath: folder.path) {
            try? fm.createDirectory(at: folder, withIntermediateDirectories: true)
        }

        self.fileURL = folder.appendingPathComponent(fileName)
    }
    
    private func loadBundledDefaults() -> [SavedResolution] {
        guard let url = Bundle.main.url(forResource: "presets", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([DefaultResolution].self, from: data)
            return decoded.map {
                SavedResolution(
                    name: $0.name,
                    width: $0.width,
                    height: $0.height,
                    tags: Set($0.tags ?? []),
                    note: $0.note
                )
            }
        } catch {
            return []
        }
    }

    func load() -> Payload {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(Payload.self, from: data)
        } catch {
            let defaults = loadBundledDefaults()
            return Payload(saved: defaults)
        }
    }

    func save(_ payload: Payload) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601

        let data = try encoder.encode(payload)
        try data.write(to: fileURL, options: [.atomic])
    }
}
