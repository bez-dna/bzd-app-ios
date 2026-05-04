import SwiftUI

@Observable
final class UsersListModel {
  var users: [GetUsersResponseModel.User] = []

  var isEmpty: Bool {
    users.isEmpty
  }
}
