import SwiftUI

@Observable
final class MessageService {
  let model: MessageModel = .init()

  @ObservationIgnored
  let messageId: UUID

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(api: ApiClient, messageId: UUID) {
    self.api = MessagesApiImpl(api)
    self.messageId = messageId
  }

  func loadMessage() async throws {
    model.isLoading.message = true
    defer { model.isLoading.message = false }

    let res = try await api.getMessage(req: .init(messageId: messageId))

    model.message = .init(from: res.message)
  }

  func loadMessages() async throws {
    if model.lastCursorMessageId {
      return
    }

    model.isLoading.messages = true
    defer {
      model.isLoading.messages = false
//      model.isInit = true
    }

    let res = try await api.getMessageMessages(req: .init(messageId: messageId, model: .init(cursorMessageId: model.cursorMessageId)))

    model.cursorMessageId = res.cursorMessageId
    model.messages = model.messages.append(res.messages.map { message in .init(from: message) })
    model.topics = res.topics.map { topic in .init(from: topic) }
    model.messagesTopics = res.messagesTopics.map { messageTopic in .init(from: messageTopic) }

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
