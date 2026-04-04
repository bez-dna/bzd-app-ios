import SwiftUI

struct AuthView: View {
  private let onComplete: () -> Void

  @Environment(AppState.self)
  private var state

  init(onComplete: @escaping () -> Void) {
    self.onComplete = onComplete
  }

  var body: some View {
    JoinView(api: state.api, authService: state.authService) {
      onComplete()
    }
  }
}

#Preview {
  AuthView {}
    .environment(AppState())
}

#Preview("AuthView RU") {
  AuthView {}
    .environment(AppState())
    .environment(\.locale, .init(identifier: "ru"))
}
