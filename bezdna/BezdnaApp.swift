import SwiftUI

@main
struct BezdnaApp: App {
  @State
  private var state = AppState()

  @State
  private var flow: AppFlow = .main

  var body: some Scene {
    WindowGroup {
      switch flow {
      case .auth:
        AuthView() {
          flow = .main
        }.environment(state)

      case .main:
        AppView().environment(state)
      }
    }
  }
}
