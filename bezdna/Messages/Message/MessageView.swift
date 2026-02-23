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
  private(set) var service: MessageService

  @Bindable
  private(set) var nav: AppNav

  @Environment(AppState.self)
  private var state

  var body: some View {
    let model = service.model

    ForEach(model.messages.messageIds.reversed(), id: \.self) { messageId in
      if let message = model.messages.messages[messageId] {
        if message.messageId == service.messageId {
          SourceMessageBubbleView(
            api: state.api,
            model: .init(m: message, t: model.topics),
          )
          .padding(.horizontal, AppSettings.Padding.x)
          .padding(.bottom, AppSettings.Padding.y * 2)
        } else {
          MessageBubbleView(
            api: state.api,
            model: .init(m: message, t: model.topics),
          ) { messageId in
            nav.path.append(AppRoute.message(messageId: messageId))
          }
        }
      }
    }
  }
}

struct BottomAnchor: Hashable {}

#Preview {
  let state = AppState()

  MessageView(api: state.api, nav: AppNav(), messageId: UUID(uuidString: "019c388a-0793-7263-987c-b47aeb45d188")!)
    .environment(state)
}
