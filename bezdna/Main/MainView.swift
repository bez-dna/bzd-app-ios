import SwiftUI

struct MainView: View {
  private var state: AppState

  @Bindable
  private var nav: AppNav

  init(_ state: AppState) {
    self.state = state
    nav = state.nav
  }

  var body: some View {
    NavigationStack(path: $nav.main) {
      //      Button("USERS") {
      //        nav.main.append(MainRoute.users)
      //      }

      MessagesListView(state).navigationDestination(for: MainRoute.self) { route in
        switch route {
        case let .message(messageId):
          MessageView(state, messageId)
        case .users:
          UsersView()
        case let .user(userId):
          UserView(userId)
        }
      }
    }
  }
}

#Preview {
  MainView(AppState())
}
