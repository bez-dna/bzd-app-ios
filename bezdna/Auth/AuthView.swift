import SwiftUI

struct AuthView: View {
  @Environment(AppState.self) private var state
  @State private var store = AuthStore.shared
  @State private var flow: AuthFlow = .join

  var body: some View {
    Group {
      switch flow {
      case .join:
        JoinView { verificationId in
          flow = .complete(verificationId)
        }

      case .complete(let verificationId):
        CompleteView(verificationId) { token in
          store.save(token)
          state.isAuth = true
          state.nav.flow = .main
        }
      }
    }
  }
}

#Preview {
  AuthView().environment(AppState())
}
