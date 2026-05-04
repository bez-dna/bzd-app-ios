import SwiftUI

@Observable
final class UsersListService {
  var model: UsersListModel = .init()
  var phase: AppPhase = .idle

  @ObservationIgnored
  private let api: UsersApi

  init(api: ApiClient) {
    self.api = UsersApiImpl(with: api)
  }

  func load() async {
    phase = .loading

    do {
      let res = try await api.getUsers(req: .init())

      model.users = res.users
      phase = .loaded
    } catch {
      phase = .failed(AppError(error: AppI18n.error))
    }
  }
}
