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
    service = .init(api: api)
    self.nav = nav
    self.authService = authService
  }

  var body: some View {
    @Bindable
    var model = service.model

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack(spacing: 0) {
          switch service.phase {
          case .idle, .loading:
            ProgressView().padding(.top, 16)

          case .loaded:
            if let user = state.model.user {
              UsersListUserView(user: user) { userId in
                nav.path.append(AppRoute.user(userId: userId))
              }.padding(.horizontal, 16).padding(.bottom, 8)
            }

            if model.isEmpty {
              UsersContactsView(api: state.api) {
                Task {
                  await service.load()
                }
              }
            } else {
              ForEach(model.users, id: \.userId) { user in
                UsersListBubbleView(user) { userId in
                  nav.path.append(AppRoute.user(userId: userId))
                }.padding(.horizontal, 16).padding(.bottom, 8)
              }
            }

          case let .failed(error):
            ErrorView(error: error)
          }
        }
      }
    }.task {
      await service.load()
    }.toolbar {
      ToolbarItem(placement: .topBarLeading) {
        NavBackView(nav: nav)
      }
    }
  }
}

#Preview {
  let state = AppState()

  UsersListView(api: state.api, nav: AppNav(), authService: state.authService).environment(state)
}

#Preview("UsersListView RU") {
  let state = AppState()

  UsersListView(
    api: state.api,
    nav: AppNav(),
    authService: state.authService,
  )
  .environment(state)
  .environment(\.locale, .init(identifier: "ru"))
}
