import SwiftUI

struct AppView: View {
  @Environment(AppState.self)
  private var state

  var body: some View {
    switch state.nav.flow {
    case .auth:
      AuthView(state)

    case .main:
      MainView(state)
    }
  }
}

#Preview {
  AppView().environment(AppState())
}
