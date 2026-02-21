
import Contacts
import SwiftUI

@Observable
final class TopicsService {
  var model: TopicsModel = .init()

  @ObservationIgnored
  private let api: TopicsApi

  init(api: ApiClient) {
    self.api = TopicsApiImpl(api)
  }

  func load() async throws {
    let res = try await api.getTopics(req: .init())

    model.topics = res.topics
    model.emojis = res.emojis
    model.permissions = res.permissions
  }

  func createTopic(title: String) async throws {
    _ = try await api.createTopic(req: .init(model: .init(title: title)))
  }
}
