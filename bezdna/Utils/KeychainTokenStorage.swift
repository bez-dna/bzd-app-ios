import Foundation
import Security

final class KeychainTokenStorage : TokenStorage {
  var key: String { "jwt" }

  static let shared = KeychainTokenStorage()
  // Тут нужно кучу какого-то дерьма написать для SecItemAdd с кастом в CFDictionary, поэтому потом

  func save(_ token: String) {
  }

  func load() -> String? {
    return nil
  }
}
