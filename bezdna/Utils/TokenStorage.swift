protocol TokenStorage {
  var key: String { get }

  func save(_ token: String)

  func load() -> String?
}
