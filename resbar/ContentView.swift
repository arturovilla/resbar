//
//  ContentView.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/11/26.
//

import SwiftUI

/// MenuBarExtra(.menu) content should be composed of menu-style items:
/// Text / Button / Menu / Divider / Toggle, etc.
/// Avoid layout-driven containers like VStack/HStack/List for menu reliability.
struct ContentView: View {
    @EnvironmentObject private var vm: ResolutionsViewModel

    var body: some View {
        // Header (menu label)
        Text("resbar")

        // Connected Displays section
        Text("Connected Displays")
        if vm.displays.isEmpty {
            Text("No displays detected")
        } else {
            ForEach(vm.displays) { d in
                Text("\(d.name): \(d.label)")
            }
        }

        Divider()

        // Saved Resolutions section
        Text("Saved Resolutions")
        if vm.saved.isEmpty {
            Text("No saved resolutions yet")
        } else {
            ForEach(vm.saved) { item in
                // Use Button if you want it to be clickable later; Text if read-only
                Button("\(item.name) — \(item.label)") {
                    // no-op for now (reference-only app)
                }
            }
        }

        Divider()

        SettingsLink { Label("Settings…", systemImage: "gearshape") }

        Button("Quit resbar") {
            NSApp.terminate(nil)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ResolutionsViewModel())
}
