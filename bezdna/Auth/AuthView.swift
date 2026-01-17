import SwiftUI

struct AuthView: View {
  private let state: AppState

  @State
  private var flow: AuthFlow = .join

  init(_ state: AppState) {
    self.state = state
  }

  var body: some View {
    Group {
      switch flow {
      case .join:
        JoinView(state) { verificationId in
          flow = .complete(verificationId)
        }

      case let .complete(verificationId):
        CompleteView(state, verificationId)
      }
    }
  }
}

#Preview {
  AuthView(AppState())
}
