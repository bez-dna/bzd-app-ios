import SwiftUI

struct MessagesListView: View {
  private let onAuthPress: () -> Void

  @Environment(AppState.self)
  private var state

  @State
  private var service: MessagesListService

  @Bindable
  var nav: AppNav

  init(api: ApiClient, nav: AppNav, onAuthPress: @escaping () -> Void) {
    let service: MessagesListService = .init(api: api)

    self.service = service
    self.nav = nav
    self.onAuthPress = onAuthPress
  }

  var body: some View {
    VStack {
      if state.isAuth() {
        MessagesList(service: service, nav: nav)
      } else {
        MessageListAuthView {
          onAuthPress()
        }
      }
    }
  }
}

struct MessagesList: View {
  @Bindable
  private(set) var service: MessagesListService

  @Bindable
  private(set) var nav: AppNav

  @Environment(AppState.self)
  private var state

  var body: some View {
    @Bindable
    var model = service.model

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack(spacing: 0) {
          if let user = state.model.user {
            MessagesListUserView(user: user) {
              nav.path.append(AppRoute.users)
            }.padding(.horizontal, 16).padding(.bottom, 8)
          }

          CreateMessageView(state: state, messageId: nil) { messageId in
            nav.path.append(AppRoute.message(messageId: messageId))
          }
          .padding(.horizontal, AppSettings.Padding.x)
          .padding(.bottom, 16)

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

          if model.isLoading {
            ProgressView().padding(.top, 16)
          }

          if model.isInit, !model.isLoading, model.messages.messageIds.isEmpty {
            MessageListEmptyView {
              nav.path.append(AppRoute.users)
            }
          }

          Color.clear
            .frame(height: 0)
            .onAppear {
              Task {
                do {
                  try await service.load()
                } catch {
                  print(error)
                }
              }
            }
        }
      }
    }
  }
}

struct MessageListEmptyView: View {
  private let onPress: () -> Void

  init(onPress: @escaping () -> Void) {
    self.onPress = onPress
  }

  var body: some View {
    HStack {
      Text(AppI18n.Messages.List.empty)
        .multilineTextAlignment(.center)
        .font(.system(size: AppSettings.Font.middle))
        .padding(.vertical, AppSettings.Padding.y * 4)
        .padding(.horizontal, AppSettings.Padding.x * 2)
    }

    Button {
      onPress()
    } label: {
      HStack {
        Text(AppI18n.Messages.List.contacts).colorInvert().font(.system(size: AppSettings.Font.button, weight: .bold))

        Image(systemName: "person.2.fill")
          .font(.system(size: 16))
          .colorInvert()
          .frame(height: 30)
      }
    }.buttonStyle(.plain)
      .padding(.leading, AppSettings.Padding.x)
      .padding(.trailing, AppSettings.Padding.y)
      .frame(height: AppSettings.Padding.y * 5)
      .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2.5))
  }
}

struct MessageListAuthView: View {
  private let onPress: () -> Void

  init(onPress: @escaping () -> Void) {
    self.onPress = onPress
  }

  var body: some View {
    VStack(spacing: 0) {
      Text(AppI18n.Messages.Auth.title)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.system(size: AppSettings.Font.middle, weight: .bold))
        .padding(.bottom, AppSettings.Padding.y * 2)

      Text(AppI18n.Messages.Auth.desc)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.system(size: AppSettings.Font.middle))
        .padding(.bottom, AppSettings.Padding.y * 4)

      Button {
        onPress()
      } label: {
        Text(AppI18n.Messages.Auth.button)
          .colorInvert()
          .font(.system(size: AppSettings.Font.button, weight: .bold))
          .frame(height: AppSettings.Padding.y * 5)
      }.buttonStyle(.plain)
        .padding(.horizontal, AppSettings.Padding.x)
        .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2.5))
    }.padding(.horizontal, AppSettings.Padding.x * 2)
  }
}

#Preview {
  let state = AppState()

  MessagesListView(
    api: state.api,
    nav: AppNav(),
    onAuthPress: {},
  ).environment(state)
}

#Preview("MessagesListView RU") {
  let state = AppState()

  MessagesListView(
    api: state.api,
    nav: AppNav(),
    onAuthPress: {},
  ).environment(state).environment(\.locale, .init(identifier: "ru"))
}
