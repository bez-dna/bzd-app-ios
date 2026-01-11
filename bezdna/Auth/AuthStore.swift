import Combine
import SwiftUI

@Observable
final class AuthStore {
  var token: String? = nil
  private let storage: TokenStorage = UserDefaultsTokenStorage()

  static let shared = AuthStore()

  init() {
    self.token = storage.load()
  }

  func save(_ token: String) {
    self.token = token

    storage.save(token)
  }
}
