
import SwiftUI

@Observable
final class UserService {
  var model: UserModel = .init()

  @ObservationIgnored
  let userId: UUID

  @ObservationIgnored
  private let api: UsersApi

  init(api: ApiClient, userId: UUID) {
    self.api = UsersApiImpl(with: api)
    self.userId = userId
  }

  func loadUser() async throws {
    model.isLoading.user = true
    defer { model.isLoading.user = false }

    let res = try await api.getUser(req: .init(userId: userId))

    model.user = res.user
    model.permissions = res.permissions
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

    let res = try await api.getUserMessages(req: .init(userId: userId, model: .init(cursorMessageId: model.cursorMessageId)))

    model.cursorMessageId = res.cursorMessageId
    model.messages = model.messages.append(res.messages.map { message in .init(from: message) })
    model.topics = res.topics.map { topic in .init(from: topic) }

    if res.cursorMessageId == nil {
      model.lastCursorMessageId = true
    }
  }
}
