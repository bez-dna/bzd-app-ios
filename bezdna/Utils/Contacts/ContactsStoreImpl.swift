import Contacts
import SwiftUI

final class ContactsStoreImpl: ContactsStore {
  func getStatus() -> ContactsStoreStatus {
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
    let store = CNContactStore()

    return try await store.requestAccess(for: .contacts)
  }

  func fetchContacts() async -> [ContactsStoreContact] {
    await Task.detached(priority: .userInitiated) {
      var contacts: [ContactsStoreContact] = []

      let store = CNContactStore()
      let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
      let req = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

      do {
        try store.enumerateContacts(with: req) { contact, _ in
          for phoneNumber in contact.phoneNumbers {
            contacts.append(ContactsStoreContact(
              name: "\(contact.givenName) \(contact.familyName)",
              phone: phoneNumber.value.stringValue,
              deviceContactId: contact.identifier,
            ))
          }
        }
      } catch {}

      return contacts
    }.value
  }
}
