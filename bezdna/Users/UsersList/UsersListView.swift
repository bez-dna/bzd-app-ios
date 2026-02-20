import SwiftUI

struct UsersListView: View {
  @State
  private var service: UsersListService

  @Environment(AppState.self)
  private var state

  @Bindable
  private var nav: AppNav

  @Bindable
  private var authService: AuthService

  init(api: ApiClient, nav: AppNav, authService: AuthService) {
    let service: UsersListService = .init(api: api)

    self.service = service
    self.nav = nav
    self.authService = authService
  }

  var body: some View {
    @Bindable
    var model = service.model

    // Нужно доделать разные кейсы получения доступа к контактам и списком контактов.
    // Основная идея в том чтобы никогда не было пустого экрана, должны быть подсказки что сделать чтобы найти контакты.
    // Это важно потому что в этом суть приложения.

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack(spacing: 0) {
          if let user = state.model.user {
            UsersListUserView(user: user) { userId in
              nav.path.append(AppRoute.user(userId: userId))
            }.padding(.horizontal, 16).padding(.bottom, 8)
          }

          ForEach(model.users, id: \.userId) { user in
            UsersListBubbleView(user) { userId in
              nav.path.append(AppRoute.user(userId: userId))
            }.padding(.horizontal, 16).padding(.bottom, 8)
          }

          if model.isInit, !model.isLoading, model.users.isEmpty {
            UsersListEmpty()
          }

          if model.isLoading {
            ProgressView().padding(.top, 16)
          } else {
            UsersContactsView(state: state)
          }
        }
      }
    }.task {
      do {
        try await service.load()

      } catch {
        print(error)
      }
    }
  }
}

struct UsersListEmpty: View {
  var body: some View {
    Text(AppI18n.Users.List.empty)
      .multilineTextAlignment(.center)
      .padding(.vertical, AppSettings.Padding.y * 4)
      .padding(.horizontal, AppSettings.Padding.x * 2)
  }
}

#Preview {
  let state = AppState()

  UsersListView(api: state.api, nav: AppNav(), authService: state.authService).environment(state)
}
