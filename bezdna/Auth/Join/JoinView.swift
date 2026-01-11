import SwiftUI

struct JoinView: View {
  @State private var store = JoinStore()

  let onComplete: (UUID) -> Void

  var body: some View {
    TextField("PHONE", text: $store.model.phoneNumber)

    Button("ENTER") {
      Task {
        let model = try await store.join()

        onComplete(model.verification.verificationId)
      }
    }
  }
}
