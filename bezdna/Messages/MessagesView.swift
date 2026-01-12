import SwiftUI

struct MessagesView: View {
  @Environment(AppState.self) private var state
  @State private var txt = ""

  var body: some View {
    VStack {
//      if !state.isAuth {
        Text("AUTH PLEASE")
//
        Button("TO AUTH") {
          state.nav.flow = .auth
        }
//      } else {
//        Text("MESSAGES")
//
//        Button("TO USERS") {
//          state.nav.flow = .main
//        }
//      }
    }
  }
}

#Preview {
  MessagesView().environment(AppState())
}
