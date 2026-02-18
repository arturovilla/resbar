//
//  SettingsView.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/17/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: ResolutionsViewModel

    @State private var name: String = ""
    @State private var width: String = ""
    @State private var height: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Settings").font(.headline)

            TextField("Name (e.g. 1440p)", text: $name)
            HStack {
                TextField("Width", text: $width).frame(width: 120)
                Text("×")
                TextField("Height", text: $height).frame(width: 120)
            }

            Button("Save") {
                guard let w = Int(width), let h = Int(height), w > 0, h > 0 else { return }
                vm.add(name: name, width: w, height: h)
                name = ""
                width = ""
                height = ""
            }
        }
        .padding()
        .frame(width: 420, height: 240)
    }
}
