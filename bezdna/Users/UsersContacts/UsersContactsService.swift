import Contacts
import SwiftUI

@Observable
final class UsersContactsService {
  var model: UsersContactsModel

  @ObservationIgnored
  private let api: UsersApi

  @ObservationIgnored
  private let store: ContactStore

  init(api: ApiClient, store: ContactStoreImpl = .init()) {
    self.api = UsersApiImpl(with: api)
    self.store = store
    model = .init(status: store.getStatus())
  }

  func status() -> ContactStoreStatus {
    store.getStatus()
  }

  func sync() async throws {
    let granted = try await store.requestPermission()

    if granted {
      let contacts = try store.fetchContacts().flatMap { contact in
        contact.phoneNumbers.map { phoneNumber in
          CreateContactsRequestModel.Contact(
            name: "\(contact.givenName) \(contact.familyName)",
            phoneNumber: phoneNumber.value.stringValue,
            deviceContactId: contact.identifier,
          )
        }
      }

      _ = try await api.createContacts(req: .init(model: .init(contacts: contacts)))
    }
  }
}
