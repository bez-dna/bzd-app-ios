
import Contacts
import SwiftUI

@Observable
final class UserTopicsService {
  var model: UserTopicsModel = .init()

  @ObservationIgnored
  let userId: UUID

  @ObservationIgnored
  private let api: UsersApi

  init(api: ApiClient, userId: UUID) {
    self.api = UsersApiImpl(with: api)
    self.userId = userId
  }

  func load() async throws {
    let res = try await api.getUserTopics(req: .init(userId: userId))

    model.topics = res.topics
    model.topicsUsers = res.topicsUsers
    model.permissions = res.permissions
  }

  func createTopicUser(topicId: UUID) async throws {
    _ = try await api.createTopicUser(
      req: .init(model: .init(topicId: topicId)),
    )
  }

  func deleteTopicUser(topicUserId: UUID) async throws {
    _ = try await api.deleteTopicUser(
      req: .init(model: .init(topicUserId: topicUserId)),
    )
  }
}
