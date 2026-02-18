//
//  resbarApp.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/11/26.
//

import SwiftUI

@main
struct resbarApp: App {
    @StateObject private var vm = ResolutionsViewModel()
    var body: some Scene {
        MenuBarExtra("resbar", systemImage: "display") {
            Text("Connected Displays")
            if vm.displays.isEmpty {
                Text("No displays detected")
            } else {
                ForEach(vm.displays) { d in
                    Text("\(d.name): \(d.label)")
                }
            }

            Divider()

            Text("Saved Resolutions")
            if vm.saved.isEmpty {
                Text("No saved resolutions yet")
            } else {
                ForEach(vm.saved) { item in
                    Text("\(item.name) — \(item.label)")
                }
            }

            Divider()

            SettingsLink { Label("Settings…", systemImage: "gearshape") }
            Button("Quit resbar") { NSApp.terminate(nil) }
        }
        .menuBarExtraStyle(.menu)
        
        Settings{
            SettingsView().environmentObject(vm)
        }
    }
}
