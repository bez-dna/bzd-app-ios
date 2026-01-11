import Combine
import SwiftUI

@Observable
final class AuthStore {
  var token: String? = nil

  @ObservationIgnored private let storage: TokenStorage = UserDefaultsTokenStorage()
  @ObservationIgnored private let api: AuthApi

  init(api: AuthApi = AuthApiImpl()) {
    self.api = api
    self.token = storage.load()
  }

  func load() async throws {
    let qq = try await api.me(req: MeApiRequest())

    debugPrint(qq)
  }

  func update(_ token: String) async throws {
    self.token = token

    storage.save(token)

    try await self.load()
  }
}
