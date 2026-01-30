import SwiftUI

struct MessageView: View {
  @State
  private var service: MessageService

  @Environment(AppState.self)
  private var state

  @Bindable
  private var nav: AppNav

  init(api: ApiClient, nav: AppNav, messageId: UUID) {
    let service: MessageService = .init(api: api, messageId: messageId)

    self.service = service
    self.nav = nav
  }

  var body: some View {
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

          MessageMessagesView(service: service, nav: nav)

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

struct MessageMessagesView: View {
  @Bindable
  private(set) var service: MessageService

  @Bindable
  private(set) var nav: AppNav

  var body: some View {
    @Bindable
    var model = service.model

    ForEach(model.messages.messageIds.reversed(), id: \.self) { messageId in
      if let message = model.messages.messages[messageId] {
        MessageMessagesBubbleView(message) { messageId in
          nav.path.append(AppRoute.message(messageId: messageId))
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

struct BottomAnchor: Hashable {}

//#Preview {
//  MessageView(state: AppState(), messageId: UUID(uuidString: "019c0a42-186e-7211-83c0-f446997b097b")!)
//}
