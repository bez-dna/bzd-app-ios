import SwiftUI

struct AuthView: View {
  @Environment(AppState.self) private var state
  @State private var flow: AuthFlow = .join

  var body: some View {
    Group {
      switch flow {
      case .join:
        JoinView { verificationId in
          flow = .complete(verificationId)
        }

      case .complete(let verificationId):
        CompleteView(verificationId)
      }
    }
  }
}

#Preview {
  AuthView().environment(AppState())
}
