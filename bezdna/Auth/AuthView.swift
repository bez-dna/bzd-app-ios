import SwiftUI

struct AuthView: View {
  private let onComplete: () -> Void

  @State
  private var flow: AuthFlow = .join

  @Environment(AppState.self)
  private var state

  init(onComplete: @escaping () -> Void) {
    self.onComplete = onComplete
  }

  var body: some View {
    Group {
      switch flow {
      case .join:
        JoinView(api: state.api) { verificationId in
          flow = .complete(verificationId)
        }

      case let .complete(verificationId):
        CompleteView(api: state.api, authService: state.authService, verificationId: verificationId) {
          onComplete()
        }
      }
    }
  }
}

#Preview {
  AuthView {}.environment(AppState())
}
