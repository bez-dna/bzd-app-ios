import SwiftUI

@main
struct BezdnaApp: App {
  @State private var state = AppState()

  var body: some Scene {
    WindowGroup {
      AppView().environment(state)
    }
  }
}
