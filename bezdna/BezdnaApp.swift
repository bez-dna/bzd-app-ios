import SwiftUI

@main
struct BezdnaApp: App {
  @State private var state = AppState()

  var body: some Scene {
    WindowGroup {
      AppView().environment(state).task {
//        do {
//          debugPrint(state.authService)
//          try await state.authService.loadUser()
//        } catch {}
      }
    }
  }
}
