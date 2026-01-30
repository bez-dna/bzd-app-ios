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

    model.message = res.message
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

    model.messages = model.messages.append(res.messages)
    model.cursorMessageId = res.cursorMessageId

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
