//
//  ResolutionsViewModel.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/17/26.
//

import SwiftUI
import Combine

@MainActor
final class ResolutionsViewModel: ObservableObject {
    @Published private(set) var saved: [SavedResolution] = []
    @Published private(set) var displays: [DisplaySnapshot] = []

    private let store = ResolutionStore()

    init() {
        refresh()
    }

    func refresh() {
        displays = DisplayService.fetchSnapshots()
        saved = store.load().saved
    }

    func add(name: String, width: Int, height: Int, tags: [String] = [], note: String? = nil) {
        let item = SavedResolution(
            name: name.isEmpty ? "Untitled" : name,
            width: width,
            height: height,
            tags: Set(tags),
            note: note
        )
        saved.insert(item, at: 0)
        persist()
    }

    func delete(at offsets: IndexSet) {
        saved.remove(atOffsets: offsets)
        persist()
    }

    private func persist() {
        do { try store.save(.init(saved: saved)) }
        catch { print("Save failed: \(error)") }
    }
}
