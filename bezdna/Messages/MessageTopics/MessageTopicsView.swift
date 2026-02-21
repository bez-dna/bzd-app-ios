import SwiftUI

struct MessageTopicsView: View {
  @State
  private var service: MessageTopicsService

  @Environment(AppState.self)
  private var state

  init(api: ApiClient, messageId: UUID) {
    let service: MessageTopicsService = .init(api: api, messageId: messageId)

    self.service = service
  }

  var body: some View {
    @Bindable
    var model = service.model

    ScrollViewReader { _ in
      ScrollView {
        LazyVStack {
          ForEach(model.topics, id: \.topicId) { topic in
            HStack(alignment: .top, spacing: 0) {
              Text(topic.title)
                .font(.system(size: AppSettings.Font.main))
                .lineLimit(1).frame(maxWidth: .infinity, alignment: .leading)

              // нужно сделать оформление кнопок
              if let messageTopic = model.messagesTopics.first(where: { messageTopic in
                messageTopic.topicId == topic.topicId
              }) {
                Button {
                  Task {
                    try await service.deleteMessageTopic(messageTopicId: messageTopic.messageTopicId)
                    try await service.load()
                  }
                } label: {
                  Text(AppI18n.Message.Topics.delete)
                }
              } else {
                Button {
                  Task {
                    do {
                      try await service.createMessageTopic(topicId: topic.topicId)
                      try await service.load()
                    } catch {
                      print(error)
                    }
                  }
                } label: {
                  Text(AppI18n.Message.Topics.create)
                }
              }
            }

          }.padding(.vertical, AppSettings.Padding.y)

//          CreateTopicView(api: state.api) { topicId in
//            print("CREATED \(topicId)")
//            Task {
//              do {
//                try await service.load()
//              } catch {
//                print(error)
//              }
//            }
//          }
        }.padding(.horizontal, AppSettings.Padding.x)
          .padding(.vertical, AppSettings.Padding.y * 4)
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

#Preview {
  let state = AppState()

  MessageTopicsView(api: state.api, messageId: UUID(uuidString: "019c388a-0793-7263-987c-b47aeb45d188")!)
    .environment(state)
}
