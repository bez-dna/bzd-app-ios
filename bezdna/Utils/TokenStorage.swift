protocol TokenStorage {
  var tokenKey: String { get }
  var userKey: String { get }

  func saveToken(_ token: String) throws

  func saveUser(_ user: AppModel.User) throws

  func load() throws -> (String?, AppModel.User?)
}
