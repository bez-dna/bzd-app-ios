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
          if let user = model.user {
            UserUserView(user: user)
              .padding(.bottom, AppSettings.Padding.y * 2)
          }

          VStack(spacing: AppSettings.Padding.y * 2) {
            if let permissions = model.permissions {
              if permissions.topics {
                TopicsView(api: state.api)
              }

              if permissions.topicsUsers {
                UserTopicsUsersView(api: state.api, userId: service.userId)
              }

              if permissions.logout {
                Button {
                  authService.removeToken()
                  nav.path.removeLast(nav.path.count)
                  // В теории должен немного моргнуть UI, ну и ладно :)
                } label: {
                  Text(AppI18n.Users.List.logout)
                    .colorInvert()
                    .font(.system(size: AppSettings.Font.button, weight: .bold))
                    .frame(height: 30)
                }.buttonStyle(.plain)
                  .padding(.horizontal, AppSettings.Padding.x)
                  .background(.submit, in: RoundedRectangle(cornerRadius: 15))
              }
            }
          }.padding(.bottom, AppSettings.Padding.y * 2)

          ForEach(model.messages.messageIds, id: \.self) { messageId in
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
                try await service.loadMessages()
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

struct UserUserView: View {
  private let user: GetUserResponseModel.User

  init(user: GetUserResponseModel.User) {
    self.user = user
  }

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        Rectangle().fill(Color(hex: user.color)).cornerRadius(30)
        Text(user.abbr).font(.system(size: AppSettings.Font.main, weight: .bold))
      }.frame(width: 60, height: 60)

      Text(user.name).lineLimit(1).font(.system(size: AppSettings.Font.middle, weight: .bold))
    }
  }
}

#Preview {
  let state = AppState()

  UserView(api: state.api, nav: AppNav(), userId: UUID(uuidString: "019c0344-23fc-7682-80d7-521add0d13bd")!)
    .environment(\.locale, .init(identifier: "ru"))
    .environment(state)
}
