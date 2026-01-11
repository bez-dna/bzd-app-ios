import SwiftUI

struct CompleteView: View {
  private let verificationId: UUID

  @Environment(AppState.self) private var state
  @State private var store = CompleteStore()

  init(_ verificationId: UUID) {
    self.verificationId = verificationId
  }

  var body: some View {
    TextField("CODE", text: $store.model.code)

    Button("ENTER") {
      Task {
        let model = try await store.complete(self.verificationId)
        try await state.auth.update(model.jwt)

        state.nav.flow = .main
      }
    }
  }
}

#Preview {
  CompleteView(UUID.init()).environment(AppState())
}
