import Contacts

protocol ContactStore {
  func requestPermission() async throws -> Bool

  func fetchContacts() throws -> [CNContact]
}
