import SwiftUI

struct AppError: Identifiable {
  let error: LocalizedStringKey
  let id = UUID()
}
