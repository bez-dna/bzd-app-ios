import SwiftUI

struct MessageView: View {
  private let state: AppState
  private let service: MessageService

//  @State
//  private var model: MessageModel

  init(state: AppState, messageId: UUID) {
    self.state = state

    service = MessageService(api: state.api, messageId: messageId)
  }

  var body: some View {
    @Bindable
    var nav = state.nav

    @Bindable
    var model = service.model

    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack {
          Color.clear
            .frame(height: 0)
            .background(.green)
            .onAppear {
              Task {
                try await service.load()
              }
            }

          ForEach(model.messages.reversed(), id: \.messageId) { message in
            MessageBubble(message) {
              print("NAV")
              nav.main.append(MainRoute.message(messageId: message.messageId))
            }
          }

          Group {
            CreateMessageView(state: state, messageId: service.messageId) { messageId in
              print(messageId)
            }
          }.id(BottomAnchor()).padding(.horizontal, 16).padding(.bottom, 16)
        }
      }
      .onChange(of: model.messages.count) {
        proxy.scrollTo(BottomAnchor(), anchor: .bottom)
      }
    }
  }
}

struct MessageBubble: View {
  let message: GetMessageMessagesResponseModel.Message
  let onPress: () -> Void

  init(_ message: GetMessageMessagesResponseModel.Message, _ onPress: @escaping () -> Void) {
    self.message = message
    self.onPress = onPress
  }

  var body: some View {
    Text(message.text)

    Button("-> ") {
      print("BTN")
      onPress()
    }
  }
}

struct BottomAnchor: Hashable {}

#Preview {
  MessageView(state: AppState(), messageId: UUID())
}
