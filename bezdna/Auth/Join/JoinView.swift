import SwiftUI

struct JoinView: View {
  @State private var store = JoinStore()

  var body: some View {
    TextField("PHONE", text: $store.phoneNumber)

    Button("ENTER") {
      Task {
        try await store.join()
      }
    }
  }
}
