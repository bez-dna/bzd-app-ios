import SwiftUI

@Observable
final class MessageTopicsService {
  let model: MessageTopicsModel = .init()

  @ObservationIgnored
  private let messageId: UUID

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(api: ApiClient, messageId: UUID) {
    self.api = MessagesApiImpl(api)
    self.messageId = messageId
  }

  func load() async throws {
    let res = try await api.getMessageTopics(req: .init(messageId: messageId))

    model.topics = res.topics
    model.messagesTopics = res.messagesTopics
  }

  func createMessageTopic(topicId: UUID) async throws {
    _ = try await api.createMessageTopic(
      req: .init(model: .init(topicId: topicId, messageId: messageId))
    )
  }

  func deleteMessageTopic(messageTopicId: UUID) async throws {
    _ = try await api.deleteMessageTopic(
      req: .init(model: .init(messageTopicId: messageTopicId))
    )
  }
}
