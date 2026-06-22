import SwiftUI

struct UserView: View {
  @State
  private var service: UserService

  @Environment(AppState.self)
  private var state

  @Bindable
  private var nav: AppNav

  @State
  private var showEdit: Bool = false

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
    }.toolbar {
      ToolbarItem(placement: .topBarLeading) {
        NavBackView(nav: nav)
      }

      if let user = model.user, let permissions = model.permissions {
        ToolbarItemGroup(placement: .topBarTrailing) {
          if permissions.edit {
            Button {
              showEdit.toggle()
            } label: {
              Text(AppI18n.User.edit)
            }
            .sheet(isPresented: $showEdit) {
              NavigationStack {
                UserEditView(api: state.api, user: user) {
                  Task {
                    try await authService.loadUser()
                    try await service.loadUser()
                  }
                }.presentationDetents([.medium])
              }
            }
          }

          if permissions.logout {
            Button {
              authService.removeToken()
              nav.path.removeLast(nav.path.count)
            } label: {
              Text(AppI18n.User.logout)
            }
          }
        }
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
