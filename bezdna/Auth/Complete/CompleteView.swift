import SwiftUI

struct CompleteView: View {
  private let verificationId: UUID
  private let auth: AuthService

  @State
  private var service: CompleteService

  @Bindable
  private var state: AppState

  init(_ state: AppState, _ verificationId: UUID) {
    service = CompleteService(state.api)
    self.state = state
    auth = state.authService
    self.verificationId = verificationId
  }

  var body: some View {
    TextField("CODE", text: $service.model.code)

    Button("ENTER") {
      Task {
        let res = try await service.complete(verificationId)
        try await auth.updateToken(res.jwt)

        state.nav.flow = .main
      }
    }
  }
}

#Preview {
  CompleteView(AppState(), UUID())
}
