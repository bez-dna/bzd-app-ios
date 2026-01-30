import SwiftUI

struct CompleteView: View {
  private let verificationId: UUID
  private let authService: AuthService
  private let onComplete: () -> Void

  @State
  private var service: CompleteService

  init(api: ApiClient, authService: AuthService, verificationId: UUID, onComplete: @escaping () -> Void) {
    let service: CompleteService = .init(api)

    self.service = service
    self.authService = authService
    self.verificationId = verificationId
    self.onComplete = onComplete
  }

  var body: some View {
    TextField("CODE", text: $service.model.code)

    Button("ENTER") {
      Task {
        let res = try await service.complete(verificationId)
        try await authService.updateToken(res.jwt)

        onComplete()
      }
    }
  }
}

//#Preview {
//  CompleteView(AppState(), UUID())
//}
