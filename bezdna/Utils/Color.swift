import SwiftUI

extension Color {
  init(hex: String) {
    var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hex.removeAll { $0 == "#" }

    let value = UInt64(hex, radix: 16) ?? 0

    let r = Double((value >> 24) & 0xFF) / 255
    let g = Double((value >> 16) & 0xFF) / 255
    let b = Double((value >> 8) & 0xFF) / 255
    let a = Double(value & 0xFF) / 255

    self = Color(.sRGB, red: r, green: g, blue: b, opacity: a)
  }
}
