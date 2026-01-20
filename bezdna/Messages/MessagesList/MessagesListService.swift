import SwiftUI

@Observable
final class MessagesListService {
  private let model: MessagesListModel

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(_ api: ApiClient, _ model: MessagesListModel) {
    self.api = MessagesApiImpl(api)
    self.model = model
  }

  func load() async throws {
    if model.lastCursorMessageId {
      return
    }

    let res = try await api.getUserMessages(req: GetUserMessagesRequest(GetUserMessagesRequestModel(cursorMessageId: model.cursorMessageId)))

    model.messages.append(contentsOf: res.messages)
    model.cursorMessageId = res.cursorMessageId

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
