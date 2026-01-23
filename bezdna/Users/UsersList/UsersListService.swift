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
    print("START")
    let res = try await api.getUsers(req: .init())

    debugPrint(res)

    model.users = res.users
  }
}
