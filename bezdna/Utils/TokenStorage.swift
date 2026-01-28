protocol TokenStorage {
  var tokenKey: String { get }
  var userKey: String { get }

  func removeTokenAndUser()

  func saveToken(_ token: String)

  func saveUser(_ user: AppModel.User) throws

  func load() throws -> (String?, AppModel.User?)
}
