import SwiftUI

struct MessagesListView: View {
  private let onAuth: () -> Void

  @Environment(AppState.self)
  private var state

  @State
  private var service: MessagesListService

  @Bindable
  var nav: AppNav

  init(api: ApiClient, nav: AppNav, onAuth: @escaping () -> Void) {
    let service: MessagesListService = .init(api: api)

    self.service = service
    self.nav = nav
    self.onAuth = onAuth
  }

  var body: some View {
    VStack {
      if state.isAuth() {
        MessagesList(service: service, nav: nav)
      } else {
        Button("AUTH PLEASE") {
          onAuth()
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
            MessageListEmpty {
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

struct MessageListEmpty: View {
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
      .background(.submit)
      .frame(height: 30)
      .clipShape(RoundedRectangle(cornerRadius: 15))
  }
}

// #Preview {
//  MessagesListView(state: AppState())
// }
