import SwiftUI

struct JoinView: View {
  @State private var store = JoinStore()

  var body: some View {
    TextField("PHONE", text: $store.phoneNumber)

    Button("ENTER") {
      Task {
        do {
          try await store.join()
        } catch {
          print(error)
        }
      }
    }
  }
}
