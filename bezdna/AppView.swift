import SwiftUI

struct AppView: View {
  private(set) var onAuth: () -> Void

  @Environment(AppState.self)
  private var state

  @State
  private var nav: AppNav = .init()

  var body: some View {
    NavigationStack(path: $nav.path) {
      MessagesListView(api: state.api, nav: nav) {
        onAuth()
      }.navigationDestination(for: AppRoute.self) { route in
        switch route {
        case let .message(messageId):
          MessageView(api: state.api, nav: nav, messageId: messageId)
        case .users:
          UsersListView(api: state.api, nav: nav, authService: state.authService)
            .navigationBarBackButtonHidden()
        case let .user(userId):
          UserView(api: state.api, nav: nav, userId: userId)
            .navigationBarBackButtonHidden()
        }
      }
    }
  }
}

enum AppRoute: Hashable {
  case message(messageId: UUID)
  case users
  case user(userId: UUID)
}

#Preview {
  AppView {}.environment(AppState())
}

#Preview("AppView RU") {
  AppView {}
    .environment(AppState())
    .environment(\.locale, .init(identifier: "ru"))
}
