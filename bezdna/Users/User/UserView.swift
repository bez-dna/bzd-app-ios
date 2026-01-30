import SwiftUI

struct UserView: View {
  @State
  private var service: UserService

  @Bindable
  private var nav: AppNav

  init(api: ApiClient, nav: AppNav, userId: UUID) {
//    self.state = state
    let service: UserService = .init(api: api, userId: userId)

    self.service = service
    self.nav = nav
  }

  var body: some View {
    @Bindable
    var model = service.model

//    @Bindable
//    var nav = state.nav

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack {
          if let user = model.user {
            UserUserView(user: user).padding(.horizontal, 16).padding(.bottom, 8)
          }

          UserMessagesView(service: service, nav: nav)

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

struct UserMessagesView: View {
  @Bindable
  private var service: UserService

  @Bindable
  private var nav: AppNav

  init(service: UserService, nav: AppNav) {
    self.service = service
    self.nav = nav
  }

  var body: some View {
    @Bindable
    var model = service.model

    ForEach(model.messages.messageIds, id: \.self) { messageId in
      if let message = model.messages.messages[messageId] {
        UserMessagesBubbleView(message) { messageId in
          nav.path.append(AppRoute.message(messageId: messageId))
        }
        .padding(.horizontal, AppSettings.Padding.x)
        .padding(.bottom, AppSettings.Padding.y * 2)
      }
    }
  }
}

struct UserMessagesBubbleView: View {
  private let message: GetUserMessagesResponseModel.Message
  private let onPress: (_ messageId: UUID) -> Void

  init(_ message: GetUserMessagesResponseModel.Message, _ onPress: @escaping (_ messageId: UUID) -> Void) {
    self.message = message
    self.onPress = onPress
  }

  var body: some View {
    let user = message.user

    Button {
      onPress(message.messageId)
    } label: {
      HStack(alignment: .top, spacing: 0) {
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(20)
          Text(user.abbr).font(.system(size: AppSettings.Font.s, weight: .bold))
        }
        .frame(width: 40, height: 40)
        .padding(.trailing, AppSettings.Padding.y)

        VStack(alignment: .leading, spacing: 0) {
          Text(user.name)
            .lineLimit(1)
            .font(.system(size: AppSettings.Font.s, weight: .bold))
            .padding(.bottom, 2)

          Text(message.text)
            .font(.system(size: AppSettings.Font.main))
        }

        Spacer()
      }
    }
    .buttonStyle(.plain)
  }
}

struct UserUserView: View {
  private let user: GetUserResponseModel.User

  init(user: GetUserResponseModel.User) {
    self.user = user
  }

  var body: some View {
    VStack {
      ZStack {
        Rectangle().fill(Color(hex: user.color)).cornerRadius(30)
        Text(user.abbr).font(.system(size: AppSettings.Font.main, weight: .bold))
      }.frame(width: 60, height: 60)

      Text(user.name).lineLimit(1).font(.system(size: AppSettings.Font.middle, weight: .bold))
    }
  }
}

// #Preview {
//  UserView(state: AppState(), userId: UUID(uuidString: "019c0344-23fc-7682-80d7-521add0d13bd")!)
// }
