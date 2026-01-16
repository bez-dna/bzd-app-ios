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
    let res = try await api.getUserMessages(req: GetUserMessagesRequest())

    model.messages = res.messages
  }
}
