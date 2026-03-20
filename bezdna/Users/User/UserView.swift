import SwiftUI

struct UserView: View {
  @State
  private var service: UserService

  @Environment(AppState.self)
  private var state

  @Bindable
  private var nav: AppNav

  init(api: ApiClient, nav: AppNav, userId: UUID) {
    let service: UserService = .init(api: api, userId: userId)

    self.service = service
    self.nav = nav
  }

  var body: some View {
    let model = service.model

    @Bindable
    var authService = state.authService

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack(spacing: 0) {
          UserHeaderView(permissions: model.permissions) {
            nav.path.removeLast()
          } onLogoutPress: {
            // В теории должен немного моргнуть UI, ну и ладно :)
            authService.removeToken()
            nav.path.removeLast(nav.path.count)
          }
          .padding(.horizontal, AppSettings.Padding.x)
          .padding(.bottom, AppSettings.Padding.y)

          if let user = model.user, let permissions = model.permissions {
            UserUserView(user: user, permissions: permissions) {
              Task {
                try await authService.loadUser()
                try await service.loadUser()
              }
            }
            .padding(.horizontal, AppSettings.Padding.x)
            .padding(.bottom, AppSettings.Padding.y * 2)
          }

          VStack(spacing: 0) {
            if let permissions = model.permissions {
              if permissions.topics {
                TopicsView(api: state.api)
              }

              if permissions.topicsUsers {
                UserTopicsUsersView(api: state.api, userId: service.userId)
              }
            }
          }.padding(.bottom, AppSettings.Padding.y * 2)

          ForEach(model.messages.messageIds.reversed(), id: \.self) { messageId in
            if let message = model.messages.messages[messageId] {
              MessageBubbleView(
                api: state.api,
                model: .init(message: message, topics: model.topics, messagesTopics: model.messagesTopics),
              ) { messageId in
                nav.path.append(AppRoute.message(messageId: messageId))
              }
              .padding(.horizontal, AppSettings.Padding.x)
              .padding(.bottom, AppSettings.Padding.y * 2)
            }
          }

          Color.clear
            .frame(height: 10)
            .onAppear {
              Task {
                do {
                  try await service.loadMessages()
                } catch {
                  print(error)
                }
              }
            }
        }
      }
    }.task {
      do {
        try await service.loadUser()
      } catch {
        print(error)
      }
    }
  }
}

#Preview {
  let state = AppState()

  UserView(api: state.api, nav: AppNav(), userId: UUID(uuidString: "019c0344-23fc-7682-80d7-521add0d13bd")!)
    .environment(\.locale, .init(identifier: "ru"))
    .environment(state)
}
