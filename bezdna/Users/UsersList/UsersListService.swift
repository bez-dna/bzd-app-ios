import SwiftUI

@Observable
final class UsersListService {
  var model: UsersListModel = .init()

  @ObservationIgnored
  private let api: UsersApi

  init(api: ApiClient) {
    self.api = UsersApiImpl(with: api)
  }

  func load() async throws {
    model.isLoading = true
    defer {
      model.isLoading = false
      model.isInit = true
    }

    let res = try await api.getUsers(req: .init())

    model.users = res.users
  }
}
