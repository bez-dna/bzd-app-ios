import Contacts

protocol ContactStore {
  func getStatus() -> ContactStoreStatus

  func requestPermission() async throws -> Bool

  func fetchContacts() throws -> [CNContact]
}

enum ContactStoreStatus {
  case new
  case authorized
  case denied
}
