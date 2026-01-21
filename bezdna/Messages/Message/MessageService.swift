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

  func load() async throws {
    if model.lastCursorMessageId {
      return
    }

    let res = try await api.getMessageMessages(
      req: GetMessageMessagesRequest(
        messageId: messageId, model: GetMessageMessagesRequestModel(cursorMessageId: model.cursorMessageId),
      ))

    model.messages.append(contentsOf: res.messages)
    model.cursorMessageId = res.cursorMessageId

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
