import Contacts

protocol ContactsStore {
  func getStatus() -> ContactsStoreStatus

  func requestPermission() async throws -> Bool

  func fetchContacts() async -> [ContactsStoreContact]
}

enum ContactsStoreStatus {
  case new
  case authorized
  case denied
}

struct ContactsStoreContact {
  let name: String
  let phone: String
  let deviceContactId: String
}
