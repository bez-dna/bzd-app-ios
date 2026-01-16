import SwiftUI

@Observable
final class MessageService {
  private let model: MessageModel

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(_ api: ApiClient, _ model: MessageModel) {
    self.api = MessagesApiImpl(api)
    self.model = model
  }

  func load() async throws {
    if model.lastCursorMessageId {
      return
    }

    let res = try await api.getMessageMessages(
      req: GetMessageMessagesRequest(
        model.messageId, GetMessageMessagesRequestModel(cursorMessageId: model.cursorMessageId)))

    model.messages.append(contentsOf: res.messages)
    model.cursorMessageId = res.cursorMessageId

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
