import Contacts
import SwiftUI

@Observable
final class UsersContactsService {
  var model: UsersContactsModel

  @ObservationIgnored
  private let api: UsersApi

  @ObservationIgnored
  private let store: ContactsStore

  init(api: ApiClient, store: ContactsStoreImpl = .init()) {
    self.api = UsersApiImpl(with: api)
    self.store = store
    model = .init(status: store.getStatus())
  }

  func status() -> ContactsStoreStatus {
    store.getStatus()
  }

  func create() async {
    do {
      let granted = try await store.requestPermission()

      if granted {
        try await load()

        model.status = .authorized
      } else {
        model.status = .denied
      }
    } catch {
      model.error = AppError(error: AppI18n.error)
    }
  }

  func sync() async {
    guard model.status == .authorized else { return }

    do {
      try await load()
    } catch {}
  }

  func load() async throws {
    let contacts = await store.fetchContacts().map { contact in
      CreateContactsRequestModel.Contact(
        name: contact.name,
        phone: contact.phone,
        deviceContactId: contact.deviceContactId,
      )
    }

    _ = try await api.createContacts(req: .init(model: .init(contacts: contacts)))
  }
}
