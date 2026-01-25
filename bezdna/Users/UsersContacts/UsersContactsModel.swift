import SwiftUI

@Observable
final class UsersContactsModel {
  var status: ContactStoreStatus

  init(status: ContactStoreStatus) {
    self.status = status
  }
}
