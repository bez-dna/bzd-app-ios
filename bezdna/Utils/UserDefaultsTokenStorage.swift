import Foundation

final class UserDefaultsTokenStorage: TokenStorage {
  var tokenKey: String { "jwt" }
  var userKey: String { "user" }

  func saveToken(_ token: String) throws {
    UserDefaults.standard.set(token, forKey: tokenKey)
  }

  func saveUser(_ user: AppModel.User) throws {
    UserDefaults.standard.set(try JSONEncoder().encode(user), forKey: userKey)
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
