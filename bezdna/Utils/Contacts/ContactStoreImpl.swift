import Contacts

final class ContactStoreImpl : ContactStore {
  private let store = CNContactStore()

  func requestPermission() async throws -> Bool {
    return try await store.requestAccess(for: .contacts)
  }

  func fetchContacts() throws -> [CNContact] {
    let keys: [CNKeyDescriptor] = [
        CNContactGivenNameKey as CNKeyDescriptor,
        CNContactFamilyNameKey as CNKeyDescriptor,
        CNContactPhoneNumbersKey as CNKeyDescriptor
    ]

    let req = CNContactFetchRequest(keysToFetch: keys)

    var contacts: [CNContact] = []

    try store.enumerateContacts(with: req) { contact, _ in
      contacts.append(contact)
    }

    return contacts
  }
}
