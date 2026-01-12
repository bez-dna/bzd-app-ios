import SwiftUI

struct AuthView: View {
  private let state: AppState

  @State
  private var flow: AuthFlow = .join

  init(_ state: AppState) {
    self.state = state
  }

  var body: some View {
    VStack {
      if state.isAuth() {
        Text("AUTH")
      } else {
        Text("NO USER")
      }
    }

    Group {
      switch flow {
      case .join:
        JoinView(state) { verificationId in
          flow = .complete(verificationId)
        }

      case .complete(let verificationId):
        CompleteView(state, verificationId)
      }
    }
  }
}

#Preview {
  AuthView(AppState())
}
