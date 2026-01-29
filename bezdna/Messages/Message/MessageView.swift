import SwiftUI

struct MessageView: View {
  private let state: AppState
  private let service: MessageService

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
            .onAppear {
              Task {
                try await service.loadMessages()
              }
            }

          MessageMessagesView(service: service, nav: state.nav)

//          ForEach(model.messages.reversed(), id: \.messageId) { message in
//            MessageBubble(message) {
//              print("NAV")
//              nav.main.append(MainRoute.message(messageId: message.messageId))
//            }
//          }

          Group {
            CreateMessageView(state: state, messageId: service.messageId) { messageId in
              print(messageId)
            }
          }.id(BottomAnchor()).padding(.horizontal, 16).padding(.bottom, 16)
        }
      }
      .onChange(of: model.messages.messageIds.count) {
        proxy.scrollTo(BottomAnchor(), anchor: .bottom)
      }
    }.task {
      do {
        try await service.loadMessage()
      } catch {
        print(error)
      }
    }
  }
}

struct MessageMessagesView : View {
  @Bindable
  private var service: MessageService

  @Bindable
  private var nav: AppNav

  init(service: MessageService, nav: AppNav) {
    self.service = service
    self.nav = nav
  }

  var body: some View {
    @Bindable
    var model = service.model

    ForEach(model.messages.messageIds.reversed(), id: \.self) { messageId in
      if let message = model.messages.messages[messageId] {
        MessageMessagesBubbleView(message) { messageId in
          nav.main.append(MainRoute.message(messageId: messageId))
        }
        .padding(.horizontal, AppSettings.Padding.x)
        .padding(.bottom, AppSettings.Padding.y * 2)
      }
    }
  }
}

struct MessageMessagesBubbleView: View {
  private let message: GetMessageMessagesResponseModel.Message
  private let onPress: (_ messageId: UUID) -> Void

  init(_ message: GetMessageMessagesResponseModel.Message, _ onPress: @escaping (_ messageId: UUID) -> Void) {
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

//struct MessageBubble: View {
//  let message: GetMessageMessagesResponseModel.Message
//  let onPress: () -> Void
//
//  init(_ message: GetMessageMessagesResponseModel.Message, _ onPress: @escaping () -> Void) {
//    self.message = message
//    self.onPress = onPress
//  }
//
//  var body: some View {
//    Text(message.text)
//
//    Button("-> ") {
//      print("BTN")
//      onPress()
//    }
//  }
//}

struct BottomAnchor: Hashable {}

#Preview {
  MessageView(state: AppState(), messageId: UUID(uuidString: "019c0a42-186e-7211-83c0-f446997b097b")!)
}
