import Combine
import SwiftUI

@Observable
final class AuthStore {
  private var token: String? = nil

  static let shared = AuthStore()

  init() {
    self.token = KeychainHelper.shared.load()
  }

  func display() -> String? {
    return token
  }

  func save(token: String) {
    self.token = token
    KeychainHelper.shared.save(token: token)
  }
}
