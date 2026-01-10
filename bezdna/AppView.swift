import SwiftUI

struct AppView: View {
  @Environment(AppState.self) private var state

  var body: some View {
    switch state.nav.flow {
    case .auth:
      AuthView()

    case .main:
      MessagesView()
    }
  }
}

#Preview {
  AppView().environment(AppState())
}
