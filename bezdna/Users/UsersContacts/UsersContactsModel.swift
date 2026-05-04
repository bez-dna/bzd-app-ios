import SwiftUI

@Observable
final class UsersContactsModel {
  var status: ContactsStoreStatus
  var error: AppError?

  init(status: ContactsStoreStatus) {
    self.status = status
  }
}
