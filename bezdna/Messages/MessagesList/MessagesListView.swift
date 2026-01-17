import SwiftUI

struct MessagesListView: View {
  private var state: AppState

  @State
  private var service: MessagesListService

  @State
  private var model: MessagesListModel

  @Bindable
  private var nav: AppNav

  init(_ state: AppState) {
    let model = MessagesListModel()

    nav = state.nav
    service = MessagesListService(state.api, model)
    self.model = model
    self.state = state
  }

  var body: some View {
    VStack {
      if state.isAuth() {
        MessagesList(service: service, model: model, nav: nav)
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

struct MessagesList : View {
  @Bindable
  private var service: MessagesListService

  @Bindable
  private var model: MessagesListModel

  @Bindable
  private var nav: AppNav

  init(service: MessagesListService, model: MessagesListModel, nav: AppNav) {
    self.service = service
    self.model = model
    self.nav = nav
  }

  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack {

          Group {
            CreateMessageView()
          }.padding(.horizontal, 16).padding(.bottom, 16)

          ForEach(model.messages, id: \.messageId) { message in
            MessageListBubble(message) { messageId in
              nav.main.append(MainRoute.message(messageId: messageId))
            }
          }

          Color.clear
            .frame(height: 0)
            .background(.green)
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
  let onPress: (_ messageId: UUID) -> Void

  init(_ message: GetUserMessagesResponseModel.Message, _ onPress: @escaping (_ messageId: UUID) -> Void) {
    self.message = message
    self.onPress = onPress
  }

  var body: some View {
    Button {
      onPress(message.messageId)
    } label: {
      Text(message.text)
    }
  }
}

#Preview {
  MessagesListView(AppState())
}
