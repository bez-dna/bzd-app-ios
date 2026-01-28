import SwiftUI

struct MessagesListView: View {
  private var state: AppState

  @State
  private var service: MessagesListService

  init(state: AppState) {
    service = .init(api: state.api)
    self.state = state
  }

  var body: some View {
    @Bindable
    var nav = state.nav

    VStack {
      if state.isAuth() {
        MessagesList(state: state, service: service)
      } else {
        Button("AUTH PLEASE") {
          nav.flow = .auth
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

struct MessagesList: View {
  private let state: AppState

  @Bindable
  private var service: MessagesListService

  init(state: AppState, service: MessagesListService) {
    self.service = service
    self.state = state
  }

  var body: some View {
    @Bindable
    var model = service.model

    @Bindable
    var nav = state.nav

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack(spacing: 0) {
          if let user = state.model.user {
            MessagesListUserView(user: user) {
              nav.main.append(MainRoute.users)
            }.padding(.horizontal, 16).padding(.bottom, 8)
          }

          CreateMessageView(state: state, messageId: nil) { messageId in
            nav.main.append(MainRoute.message(messageId: messageId))
          }
          .padding(.horizontal, AppSettings.Padding.x)
          .padding(.bottom, 16)

          ForEach(model.messages.messageIds, id: \.self) { messageId in
            if let message = model.messages.messages[messageId] {
              MessageListBubble(message) { messageId in
                nav.main.append(MainRoute.message(messageId: messageId))
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
              nav.main.append(MainRoute.users)
            }
          }

          Color.clear
            .frame(height: 0)
//            .background(.blue)
            .onAppear {
              Task {
                try await service.load()
              }
            }
        }
      }
    }
  }
}

struct MessageListBubble: View {
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
      HStack(spacing: 0) {
          ZStack {
            Rectangle().fill(Color(hex: user.color)).cornerRadius(20)
            Text(user.abbr).font(.system(size: AppSettings.Font.s, weight: .bold))
          }
          .frame(width: 40, height: 40)
          .padding(.trailing, AppSettings.Padding.y)

          VStack(alignment: .leading, spacing: 0) {
            Text(user.name)
              .lineLimit(1)
              .font(.system(size: AppSettings.Font.s, weight: .medium))
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

#Preview {
  MessagesListView(state: AppState())
}
