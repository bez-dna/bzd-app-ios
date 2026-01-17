import Combine
import SwiftUI

@Observable
final class AuthService {
  private var appModel: AppModel
  private let storage: TokenStorage
  private let api: AuthApi

  init(_ appModel: AppModel, _ api: ApiClient) {
    storage = UserDefaultsTokenStorage()

    let (token, user) = (try? storage.load()) ?? (nil, nil)

    appModel.token = token
    appModel.user = user
    self.appModel = appModel

    self.api = AuthApiImpl(api)
  }

  func loadUser() async throws {
    let res = try await api.me(req: MeApiRequest())

    if let user = res.user {
      let user = AppModel.User(
        userId: user.userId, name: user.name, abbr: user.name, color: user.color,
      )
      try storage.saveUser(user)
      appModel.user = user
    }
  }

  func updateToken(_ token: String) async throws {
    try storage.saveToken(token)
    appModel.token = token

    try await loadUser()
  }
}
