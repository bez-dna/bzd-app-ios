import SwiftUI

struct UsersListView: View {
  private var state: AppState

  @State
  private var service: UsersListService

  init(state: AppState) {
    self.state = state
    service = .init(api: state.api)
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
          UsersList(service: service, nav: state.nav)

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

struct UsersList: View {
  @Bindable
  private var service: UsersListService

  @Bindable
  private var nav: AppNav

  init(service: UsersListService, nav: AppNav) {
    self.service = service
    self.nav = nav
  }

  var body: some View {
    @Bindable
    var model = service.model

    ForEach(model.users, id: \.userId) { user in
      UserListBubble(user) { userId in
        nav.main.append(MainRoute.user(userId: userId))
      }.padding(.horizontal, 16).padding(.bottom, 8)
    }
  }
}

struct UserListBubble: View {
  private let user: GetUsersResponseModel.User
  private let onPress: (_ userId: UUID) -> Void

  init(_ user: GetUsersResponseModel.User, _ onPress: @escaping (_ userId: UUID) -> Void) {
    self.user = user
    self.onPress = onPress
  }

  var body: some View {
    Button {
      onPress(user.userId)
    } label: {
      HStack {
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(20)
          Text(user.abbr).font(.system(size: 14, weight: .bold))
        }.frame(width: 40, height: 40)

        Text(user.name).lineLimit(1).font(.system(size: 16, weight: .medium))

        Spacer()
      }
    }.buttonStyle(.plain)
  }
}

#Preview {
  UsersListView(state: AppState())
}
