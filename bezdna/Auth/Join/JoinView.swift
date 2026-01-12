import SwiftUI

struct JoinView: View {
  @State
  private var service: JoinService

  let onComplete: (UUID) -> Void

  private let state: AppState

  init(_ state: AppState, _ onComplete: @escaping (UUID) -> Void) {
    self.service = JoinService(state.api)
    self.onComplete = onComplete
    self.state = state
  }

  var body: some View {
    TextField("PHONE", text: $service.model.phoneNumber).keyboardType(.phonePad)

    Button("ENTER") {
      Task {
        let model = try await service.join()

        onComplete(model.verification.verificationId)
      }
    }
  }
}

#Preview {
  JoinView(AppState()) { verificationId in print(verificationId) }
}
