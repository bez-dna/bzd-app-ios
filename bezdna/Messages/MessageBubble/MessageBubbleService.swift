import SwiftUI

@Observable
final class MessageBubbleService {
  let model: MessageBubbleModel

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(
    api: ApiClient,
    model: MessageBubbleModel,
  ) {
    self.api = MessagesApiImpl(api)
    self.model = model
  }

  func createMessageTopic(topicId: UUID) async throws {
    _ = try await api.createMessageTopic(
      req: .init(model: .init(topicId: topicId, messageId: model.messageId)),
    )

    try await getMessageMessagesTopics(messageId: model.messageId)
  }

  func deleteMessageTopic(messageTopicId: UUID) async throws {
    _ = try await api.deleteMessageTopic(
      req: .init(model: .init(messageTopicId: messageTopicId)),
    )

    try await getMessageMessagesTopics(messageId: model.messageId)
  }

  func getMessageMessagesTopics(messageId: UUID) async throws {
    let res = try await api.getMessageMessagesTopics(
      req: .init(messageId: messageId),
    )

    model.messagesTopics = res.messagesTopics.map { messageTopic in
      .init(
        messageTopicId: messageTopic.messageTopicId,
        topicId: messageTopic.topicId,
        messageId: messageTopic.messageId,
      )
    }

    model.topics = res.topics.map { topic in
      .init(topicId: topic.topicId, title: topic.title)
    }
  }
}
