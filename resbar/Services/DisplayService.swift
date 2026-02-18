//
//  DisplayService.swift
//  resbar
//
//  Created by Arturo  Villalobos on 2/17/26.
//

import AppKit
import Foundation

/// Reads connected display info for reference only.
/// This does NOT enumerate all possible CGDisplay modes yet—just “what’s connected right now”.
enum DisplayService {
    static func fetchSnapshots() -> [DisplaySnapshot] {
        NSScreen.screens.enumerated().map { idx, screen in
            let frame = screen.frame
            let scale = screen.backingScaleFactor

            // Best-effort ID: NSScreenNumber usually present
            let idString: String = {
                if let n = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? NSNumber {
                    return "display-\(n.uint32Value)"
                }
                return "display-\(idx)"
            }()

            return DisplaySnapshot(
                id: idString,
                name: "Display \(idx + 1)",
                pointsWidth: Int(frame.width),
                pointsHeight: Int(frame.height),
                scale: Double(scale)
            )
        }
    }
}
