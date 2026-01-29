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
      MessagesListView(state: state).navigationDestination(for: MainRoute.self) { route in
        switch route {
        case let .message(messageId):
          MessageView(state: state, messageId: messageId)
        case .users:
          UsersListView(state: state)
        case let .user(userId):
          UserView(state: state, userId: userId)
        }
      }
    }
  }
}

#Preview {
  MainView(AppState())
}
