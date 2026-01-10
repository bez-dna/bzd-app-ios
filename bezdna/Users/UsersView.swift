import SwiftUI

struct UsersView: View {
  @Environment(AppNav.self) var nav

  var body: some View {
    VStack {
      Text("USERS")

      Button("TO MESSAGES") {
        nav.flow = .messages
      }
    }
  }
}

#Preview {
  UsersView().environment(AppNav())
}
