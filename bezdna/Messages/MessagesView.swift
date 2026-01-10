import SwiftUI

struct MessagesView: View {
  @Environment(AppNav.self) private var nav
  @State private var txt = ""

  var body: some View {
    VStack {
      Text("MESSAGES")

      Button("TO USERS") {
        nav.flow = .users
      }

      TextField("QQ", text: $txt)
    }
  }
}

#Preview {
  MessagesView().environment(AppNav())
}
