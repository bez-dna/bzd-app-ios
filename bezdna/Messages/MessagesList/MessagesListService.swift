import SwiftUI

@Observable
final class MessagesListService {
  let model: MessagesListModel = .init()

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

    let res = try await api.getFeedMessages(req: .init(.init(cursorMessageId: model.cursorMessageId)))

    model.cursorMessageId = res.cursorMessageId
    model.messages = model.messages.append(res.messages.map { message in .init(from: message) })
    model.topics = res.topics.map { topic in .init(from: topic) }
    model.messagesTopics = res.messagesTopics.map { messageTopic in .init(from: messageTopic) }

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
