import Contacts

final class ContactStoreImpl: ContactStore {
  private let store = CNContactStore()

  func getStatus() -> ContactStoreStatus {
    let status = CNContactStore.authorizationStatus(for: .contacts)

    return switch status {
    case .notDetermined:
      .new
    case .authorized, .limited:
      .authorized
    default:
      .denied
    }
  }

  func requestPermission() async throws -> Bool {
    try await store.requestAccess(for: .contacts)
  }

  func fetchContacts() throws -> [CNContact] {
    let keys: [CNKeyDescriptor] = [
      CNContactGivenNameKey as CNKeyDescriptor,
      CNContactFamilyNameKey as CNKeyDescriptor,
      CNContactPhoneNumbersKey as CNKeyDescriptor,
    ]

    let req = CNContactFetchRequest(keysToFetch: keys)

    var contacts: [CNContact] = []

    try store.enumerateContacts(with: req) { contact, _ in
      contacts.append(contact)
    }

    return contacts
  }
}
