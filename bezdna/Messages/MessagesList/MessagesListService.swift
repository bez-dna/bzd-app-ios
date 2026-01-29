import SwiftUI

@Observable
final class MessagesListService {
  var model: MessagesListModel = .init()

  @ObservationIgnored
  private let api: MessagesApi

  init(api: ApiClient) {
    self.api = MessagesApiImpl(api)
  }

  func load() async throws {
    if model.lastCursorMessageId {
      return
    }

    model.isLoading = true
    defer {
      model.isLoading = false
      model.isInit = true
    }

    let res = try await api.getFeedMessages(req: GetFeedMessagesRequest(GetFeedMessagesRequestModel(cursorMessageId: model.cursorMessageId)))

    model.messages = model.messages.append(res.messages)
    model.cursorMessageId = res.cursorMessageId

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
