import Foundation

final class UserDefaultsTokenStorage : TokenStorage {
  var key: String { "jwt" }

  func save(_ token: String) {
    UserDefaults.standard.set(token, forKey: self.key)
  }
  
  func load() -> String? {
    UserDefaults.standard.string(forKey: self.key)
  }
  

}
