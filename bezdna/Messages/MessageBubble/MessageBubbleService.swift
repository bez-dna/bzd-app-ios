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
      req: .init(model: .init(topicId: topicId, messageId: model.message.messageId)),
    )

    try await getMessageMessagesTopics(messageId: model.message.messageId)
  }

  func deleteMessageTopic(messageTopicId: UUID) async throws {
    _ = try await api.deleteMessageTopic(
      req: .init(model: .init(messageTopicId: messageTopicId)),
    )

    try await getMessageMessagesTopics(messageId: model.message.messageId)
  }

  func getMessageMessagesTopics(messageId: UUID) async throws {
    let res = try await api.getMessageMessagesTopics(
      req: .init(messageId: messageId),
    )

    model.messagesTopics = res.messagesTopics.map { messageTopic in
      .init(from: messageTopic)
    }

    model.topics = res.topics.map { topic in
      .init(from: topic)
    }
  }
}
