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
        if message.messageId == service.messageId {
          SourceMessageBubbleView(model: .init(m: message))
            .padding(.horizontal, AppSettings.Padding.x)
            .padding(.bottom, AppSettings.Padding.y * 2)
        } else {
          MessageBubbleView(model: .init(m: message)) { messageId in
            nav.path.append(AppRoute.message(messageId: messageId))
          }
          .padding(.horizontal, AppSettings.Padding.x)
          .padding(.bottom, AppSettings.Padding.y * 2)
        }
      }
    }
  }
}

struct BottomAnchor: Hashable {}

#Preview {
  let state = AppState()

  MessageView(api: state.api, nav: AppNav(), messageId: UUID(uuidString: "019c0a42-186e-7211-83c0-f446997b097b")!)
    .environment(state)
}
