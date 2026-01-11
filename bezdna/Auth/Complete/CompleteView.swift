import SwiftUI

struct CompleteView: View {
  private let verificationId: UUID
  private let onComplete: (_ token: String) -> Void

  @State private var store = CompleteStore()

  init(_ verificationId: UUID, onComplete: @escaping (_ token: String) -> Void) {
    self.verificationId = verificationId
    self.onComplete = onComplete
  }

  var body: some View {
    TextField("CODE", text: $store.model.code)

    Button("ENTER") {
      Task {
        let model = try await store.complete(self.verificationId)

        onComplete(model.jwt)
      }
    }
  }
}

#Preview {
  CompleteView(UUID.init()) { token in print(token) }
}
