import Foundation

final class UserDefaultsTokenStorage: TokenStorage {
  var tokenKey: String { "jwt" }
  var userKey: String { "user" }

  func removeTokenAndUser() {
    UserDefaults.standard.removeObject(forKey: tokenKey)
    UserDefaults.standard.removeObject(forKey: userKey)
  }

  func saveToken(_ token: String) {
    UserDefaults.standard.set(token, forKey: tokenKey)
  }

  func saveUser(_ user: AppModel.User) throws {
    try UserDefaults.standard.set(JSONEncoder().encode(user), forKey: userKey)
  }

  func load() throws -> (String?, AppModel.User?) {
    let token = UserDefaults.standard.string(forKey: tokenKey)

    var user: AppModel.User? = nil
    if let data = UserDefaults.standard.data(forKey: userKey) {
      user = try JSONDecoder().decode(AppModel.User.self, from: data)
    }

    return (token, user)
  }
}
