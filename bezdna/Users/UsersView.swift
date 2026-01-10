import SwiftUI

struct UsersView: View {
  @Environment(AppState.self) private var state

  var body: some View {
    VStack {
      Text("USERS")
    }
  }
}

#Preview {
  UsersView().environment(AppState())
}
