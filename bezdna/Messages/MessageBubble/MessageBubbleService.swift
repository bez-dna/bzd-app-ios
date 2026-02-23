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
  }

  func deleteMessageTopic(messageTopicId: UUID) async throws {
    _ = try await api.deleteMessageTopic(
      req: .init(model: .init(messageTopicId: messageTopicId)),
    )
  }
}
